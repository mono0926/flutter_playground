import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:mono_kit/utils/logger.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

final _rootScaffoldKeyProvider = Provider((_) => GlobalKey<ScaffoldState>());

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = useProvider(_rootScaffoldKeyProvider);
    return MaterialApp(
      navigatorKey: useProvider(_navigatorKeyProvider),
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

class _HomePage extends HookWidget {
  const _HomePage({
    Key key,
    this.index = 0,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(_homePageProviders(index));
    final canPop = useProvider(_navigatorKeyProvider).currentState.canPop();
    return Scaffold(
      appBar: AppBar(title: Text('index: $index')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: const Text('Show SnackBar'),
              onPressed: controller.showSnackBar,
            ),
            RaisedButton(
              child: const Text('👉 Navigate to next page'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => _HomePage(
                      index: index + 1,
                    ),
                  ),
                );
              },
            ),
            if (canPop)
              RaisedButton(
                child: const Text('👈 Pop and show SnackBar'),
                onPressed: controller.popAndShowSnackBar,
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
  (ref, __) => _HomePageController(ref),
);

class _HomePageController {
  _HomePageController(this._ref);

  final ProviderReference _ref;

  ScaffoldState get rootScaffoldState =>
      _ref.read(_rootScaffoldKeyProvider).currentState;

  void showSnackBar() {
    rootScaffoldState.showSimpleSnackBar('Hey(　´･‿･｀)');
  }

  void popAndShowSnackBar() {
    _ref.read(_navigatorKeyProvider).currentState.pop();
    rootScaffoldState.showSimpleSnackBar('Came back(　´･‿･｀)');
  }
}
