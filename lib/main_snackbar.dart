import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';

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
      navigatorKey: useProvider(navigatorKeyProvider),
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
    final canPop = useProvider(navigatorKeyProvider).currentState.canPop();
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(title: Text('index: $index')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: const Text('Show SnackBar'),
              onPressed: () => controller.showSnackBarMessage('Hey(　´･‿･｀)'),
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

final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final _homePageProviders =
    Provider.autoDispose.family<_HomePageController, int>(
  (ref, __) {
    final controller = _HomePageController(ref);
    ref.onDispose(controller.dispose);
    return controller;
  },
);

mixin SnackBarMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  SnackBarPresenter get snackBarPresenter;
  VoidCallback _unregisterSnackBarRegistration;

  @protected
  void registerToStackBarPresenter() {
    _unregisterSnackBarRegistration = snackBarPresenter.register(scaffoldKey);
  }

  @protected
  void unregisterFromStackBarPresenter() {
    _unregisterSnackBarRegistration();
  }

  @protected
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarMessage(
    String message,
  ) {
    return snackBarPresenter.showMessage(message);
  }

  @protected
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    return snackBarPresenter.show(snackBar);
  }
}

class _HomePageController with SnackBarMixin {
  _HomePageController(this._ref) {
    registerToStackBarPresenter();
  }

  final ProviderReference _ref;

  @override
  SnackBarPresenter get snackBarPresenter =>
      _ref.read(snackBarPresenterProvider);

  void popAndShowSnackBar() {
    _ref.read(navigatorKeyProvider).currentState.pop();
    // Remove registration before showing SnackBar
    unregisterFromStackBarPresenter();
    showSnackBarMessage('Came back(　´･‿･｀)');
  }

  void dispose() {
    unregisterFromStackBarPresenter();
  }
}

final snackBarPresenterProvider = Provider(
  (_) => SnackBarPresenter(),
);

class SnackBarPresenter {
  final _scaffoldKeys = <GlobalKey<ScaffoldState>>[];

  VoidCallback register(GlobalKey<ScaffoldState> scaffoldKey) {
    assert(!_scaffoldKeys.contains(scaffoldKey));
    _scaffoldKeys.add(scaffoldKey);
    return () => _unregister(scaffoldKey);
  }

  void _unregister(GlobalKey<ScaffoldState> key) {
    assert(_scaffoldKeys.last == key || !_scaffoldKeys.contains(key));
    _scaffoldKeys.remove(key);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
    String message,
  ) {
    return show(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    SnackBar snackBar,
  ) {
    if (_scaffoldKeys.isEmpty) {
      assert(false, '_scaffoldKeys should not be empty');
      return null;
    }
    // Show SnackBar by using last ScaffoldKey
    final scaffoldState = _scaffoldKeys.last.currentState;
    if (scaffoldState == null) {
      assert(false, 'scaffoldState should not be null');
      return null;
    }
    scaffoldState.removeCurrentSnackBar();
    return scaffoldState.showSnackBar(snackBar);
  }

  void dispose() {
    _scaffoldKeys.clear();
  }
}
