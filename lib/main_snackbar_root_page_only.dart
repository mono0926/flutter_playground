import 'package:flutter/material.dart';

void main() => runApp(
      const App(),
    );

final _rootPageScaffoldKey = GlobalKey<ScaffoldState>();
final _navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

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
    this.index = 0,
  });

  final int index;

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    final canPop = _navigatorKey.currentState!.canPop();
    return Scaffold(
      key: canPop ? null : _rootPageScaffoldKey,
      appBar: AppBar(title: Text('index: ${widget.index}')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: showSnackBar,
              child: const Text('Show SnackBar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => _HomePage(
                      index: widget.index + 1,
                    ),
                  ),
                );
              },
              child: const Text('👉 Navigate to next page'),
            ),
            if (canPop)
              ElevatedButton(
                onPressed: popAndShowSnackBar,
                child: const Text('👈 Pop and show SnackBar'),
              ),
          ],
        ),
      ),
    );
  }

  ScaffoldState get _scaffoldState => _rootPageScaffoldKey.currentState!;

  void showSnackBar() {
    // ignore: deprecated_member_use
    _scaffoldState.showSnackBar(
      const SnackBar(
        content: Text('Hey(　´･‿･｀)'),
      ),
    );
  }

  void popAndShowSnackBar() {
    _navigatorKey.currentState!.pop();
    // ignore: deprecated_member_use
    _scaffoldState.showSnackBar(
      const SnackBar(
        content: Text('Came back(　´･‿･｀)'),
      ),
    );
  }
}
