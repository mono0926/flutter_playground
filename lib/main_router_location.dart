import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (_) => '/${HomeTab.values.first.name}',
        ),
        GoRoute(
          path: '/:tab(${HomeTab.values.map((t) => t.name).join('|')})',
          builder: (context, state) => HomePage(
            tab: HomeTab.values.byName(state.params['tab']!),
          ),
        ),
      ],
      navigatorBuilder: (context, state, child) => GoRouterLocationButton(
        child: child,
      ),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.tab,
  }) : super(key: key);

  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Scaffold(
      body: Center(
        child: Text(tab.name),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (index) =>
            router.go('/${HomeTab.values[index].name}'),
        destinations: HomeTab.values
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                label: tab.name,
              ),
            )
            .toList(),
      ),
    );
  }
}

enum HomeTab { a, b, c }

extension on HomeTab {
  IconData get icon {
    switch (this) {
      case HomeTab.a:
        return Icons.card_giftcard_outlined;
      case HomeTab.b:
        return Icons.account_circle;
      case HomeTab.c:
        return Icons.analytics;
    }
  }
}

class GoRouterLocationButton extends StatelessWidget {
  const GoRouterLocationButton({
    Key? key,
    required this.child,
    this.visible = true,
  }) : super(key: key);

  final Widget child;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }
    final router = GoRouter.of(context);
    final location = router.location;
    return Stack(
      children: [
        child,
        Positioned(
          right: 0,
          child: ElevatedButton(
            onPressed: () async {
              final next = (await showTextInputDialog(
                context: router.navigator!.context,
                textFields: [
                  DialogTextField(initialText: location),
                ],
              ))
                  ?.first;
              if (next != null) {
                router.go(next);
              }
            },
            child: Text(location),
          ),
        ),
      ],
    );
  }
}
