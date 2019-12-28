import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
