import 'package:flutter/material.dart';

void main() => runApp(
      const App(),
    );

final _rootPageScaffoldKey = GlobalKey<ScaffoldState>();
final _navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({
    Key key,
    this.index = 0,
  }) : super(key: key);

  final int index;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    final canPop = _navigatorKey.currentState.canPop();
    return Scaffold(
      key: canPop ? null : _rootPageScaffoldKey,
      appBar: AppBar(title: Text('index: ${widget.index}')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: const Text('Show SnackBar'),
              onPressed: showSnackBar,
            ),
            RaisedButton(
              child: const Text('👉 Navigate to next page'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => _HomePage(
                      index: widget.index + 1,
                    ),
                  ),
                );
              },
            ),
            if (canPop)
              RaisedButton(
                child: const Text('👈 Pop and show SnackBar'),
                onPressed: popAndShowSnackBar,
              ),
          ],
        ),
      ),
    );
  }

  ScaffoldState get _snackBarState => _rootPageScaffoldKey.currentState;

  void showSnackBar() {
    _snackBarState.showSnackBar(
      const SnackBar(
        content: Text('Hey(　´･‿･｀)'),
      ),
    );
  }

  void popAndShowSnackBar() {
    _navigatorKey.currentState.pop();
    _snackBarState.showSnackBar(
      const SnackBar(
        content: Text('Came back(　´･‿･｀)'),
      ),
    );
  }
}
