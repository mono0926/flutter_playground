import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

enum ResponsiveMode {
  desktop,
  mobile,
}

final responsiveModeProvider = StateProvider((ref) => ResponsiveMode.mobile);

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ).applyCommon(),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
      ).applyCommon(),
      routerConfig: ref.watch(router),
      builder: (context, child) {
        final mode = MediaQuery.of(context).size.width > 600
            ? ResponsiveMode.desktop
            : ResponsiveMode.mobile;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.watch(responsiveModeProvider.notifier).update((_) => mode);
        });
        return child!;
      },
    );
  }
}

final navigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

final router = Provider<GoRouter>((ref) {
  final isMobile = ref.watch(
    responsiveModeProvider.select((mode) => mode == ResponsiveMode.mobile),
  );
  ref.listenSelf((previous, current) {
    final previousLocation = previous?.location;
    if (previousLocation != null) {
      // TODO(mono): Check if the location exists in the new router
      current.go(previousLocation);
    }
  });
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: ref.watch(navigatorKey),
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/items',
      ),
      ...isMobile
          ? [
              GoRoute(
                path: '/items',
                builder: (context, state) => const ListPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      return DetailPage(id: state.pathParameters['id']!);
                    },
                  ),
                ],
              )
            ]
          : [
              GoRoute(path: '/items', redirect: (_, __) => '/items/0'),
              GoRoute(
                path: '/items/:id',
                builder: (context, state) {
                  return ListDetailPage(id: state.pathParameters['id']!);
                },
              ),
            ]
    ],
  );
});

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: ListView(
        children: List.generate(
          10,
          (index) => ListTile(
            title: Text('Item $index'),
            onTap: () => GoRouter.of(context).go('/items/$index'),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item $id'),
      ),
      body: Center(child: Text('Item $id')),
    );
  }
}

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListDetail'),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(
                10,
                (index) => ListTile(
                  title: Text('Item $index'),
                  tileColor: '$index' == id
                      ? colorScheme.secondary.withOpacity(0.1)
                      : null,
                  onTap: () {
                    GoRouter.of(context).go('/items/$index');
                  },
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(
            flex: 2,
            child: Center(
              child: Text('Item $id'),
            ),
          ),
        ],
      ),
    );
  }
}

extension on ThemeData {
  ThemeData applyCommon() => copyWith(
        appBarTheme: appBarTheme.copyWith(elevation: 4),
        useMaterial3: true,
      );
}
