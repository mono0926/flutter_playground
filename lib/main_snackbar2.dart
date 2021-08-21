import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

final _rootScaffoldKeyProvider = Provider((_) => GlobalKey<ScaffoldState>());

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(_rootScaffoldKeyProvider);
    return MaterialApp(
      navigatorKey: ref.watch(_navigatorKeyProvider),
      home: const _HomePage(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      builder: (context, child) => Scaffold(
        key: scaffoldKey,
        body: child,
      ),
    );
  }
}

class _HomePage extends ConsumerWidget {
  const _HomePage({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_homePageProviders(index));
    final canPop = ref.watch(_navigatorKeyProvider).currentState!.canPop();
    return Scaffold(
      appBar: AppBar(title: Text('index: $index')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: controller.showSnackBar,
              child: const Text('Show SnackBar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => _HomePage(
                      index: index + 1,
                    ),
                  ),
                );
              },
              child: const Text('👉 Navigate to next page'),
            ),
            if (canPop)
              ElevatedButton(
                onPressed: controller.popAndShowSnackBar,
                child: const Text('👈 Pop and show SnackBar'),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

final _navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final _homePageProviders =
    Provider.autoDispose.family<_HomePageController, int>(
  (ref, __) => _HomePageController(ref.read),
);

class _HomePageController {
  _HomePageController(this._read);

  final Reader _read;

  ScaffoldState get rootScaffoldState =>
      _read(_rootScaffoldKeyProvider).currentState!;

  void showSnackBar() {
//    rootScaffoldState.showSimpleSnackBar('Hey(　´･‿･｀)');
  }

  void popAndShowSnackBar() {
    _read(_navigatorKeyProvider).currentState!.pop();
//    rootScaffoldState.showSimpleSnackBar('Came back(　´･‿･｀)');
  }
}
