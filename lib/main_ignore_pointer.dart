import 'package:flutter/material.dart';
import 'package:version/version.dart';

void main() {
  print(Version.parse('1.0.0').compareTo(Version.parse('1.0.0-0')));
  print(Version.parse('1.0.0-d').compareTo(Version.parse('1.0.0-0')));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Dog'),
            ),
          ),
        ),
        IgnorePointer(
          child: ColoredBox(
            color: Colors.red.withOpacity(0.3),
            child: Center(
              child: Text('(　´･‿･｀)'),
            ),
          ),
        )
      ],
    );
  }
}
