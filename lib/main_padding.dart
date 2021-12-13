import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const _sidePadding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            const Padding(
              padding: _sidePadding,
              child: Placeholder(fallbackHeight: 48),
            ),
            Padding(
              padding: _sidePadding + const EdgeInsets.symmetric(vertical: 8),
              child: const Placeholder(fallbackHeight: 48),
            ),
            const Placeholder(fallbackHeight: 48),
          ],
        ),
      ),
    );
  }
}
