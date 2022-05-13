import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: List<Widget>.generate(
          5,
          (index) => Text('$index'),
        ).intersperse(const Divider()).toList(),
      ),
    );
  }
}
