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

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: useProvider(_navigatorKeyProvider),
      home: const _HomePage(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
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
      key: controller.scaffoldKey,
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
                onPressed: controller.backAndShowSnackBar,
              ),
          ],
        ),
      ),
    );
  }
}

final _navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final _homePageProviders =
    Provider.autoDispose.family<_HomePageController, int>(
  (ref, __) {
    final controller = _HomePageController(ref);
    ref.onDispose(controller.dispose);
    return controller;
  },
);

class _HomePageController {
  _HomePageController(this._ref) {
    _removeSnackBarRegistration =
        _snackBarMessageDispatcher.register(scaffoldKey);
  }

  final ProviderReference _ref;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  _SnackBarMessageDispatcher get _snackBarMessageDispatcher =>
      _ref.read(_snackBarMessageDispatcherProvider);

  VoidCallback _removeSnackBarRegistration;

  void showSnackBar() {
    _snackBarMessageDispatcher.show('Hey(　´･‿･｀)');
  }

  void backAndShowSnackBar() {
    _ref.read(_navigatorKeyProvider).currentState.pop();
    // Remove registration before showing SnackBar
    _removeSnackBarRegistration();
    _snackBarMessageDispatcher.show('Came back(　´･‿･｀)');
  }

  void dispose() {
    _removeSnackBarRegistration();
  }
}

final _snackBarMessageDispatcherProvider = Provider(
  (_) => _SnackBarMessageDispatcher(),
);

class _SnackBarMessageDispatcher {
  final _scaffoldKeys = <GlobalKey<ScaffoldState>>[];

  VoidCallback register(GlobalKey<ScaffoldState> scaffoldKey) {
    _scaffoldKeys.add(scaffoldKey);
    return () => _scaffoldKeys.remove(scaffoldKey);
  }

  void show(String message) {
    if (_scaffoldKeys.isEmpty) {
      logger.info('_presenters.isEmpty');
      return;
    }
    // Show SnackBar by using last ScaffoldKey
    _scaffoldKeys.last.currentState.showSimpleSnackBar(message);
  }

  void dispose() {
    _scaffoldKeys.clear();
  }
}
