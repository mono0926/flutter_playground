import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isPushed = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage<void>(
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPushed = true;
                  });
                },
                child: const Text('Dog'),
              ),
            ),
          ),
          name: 'Dog',
        ),
        if (_isPushed)
          MaterialPage<void>(
            child: Scaffold(
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
