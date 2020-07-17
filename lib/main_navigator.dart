import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isPushed = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage<void>(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: RaisedButton(
                child: const Text('Dog'),
                onPressed: () {
                  setState(() {
                    _isPushed = true;
                  });
                },
              ),
            ),
          ),
          name: 'Dog',
        ),
        if (_isPushed)
          MaterialPage<void>(
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: Text('🐶'),
              ),
            ),
            name: '🐶',
          ),
      ],
      onPopPage: (Route<void> route, void result) {
        _isPushed = false;
        return route.didPop(result);
      },
    );
  }
}
