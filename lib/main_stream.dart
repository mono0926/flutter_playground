import 'dart:async';

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
  final _sc = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();

    // printの中身を書き換えてからHot Reloadしても反映されない(Hot Restartで反映)
    _sc.stream.listen((message) => print('initState: $message'));
    _sc.stream.listen(_listener);

    // 上と同じく
    void listener(String message) => print('initState(listener): $message');
    _sc.stream.listen(listener);
  }

  // printの中身を書き換えてからHot Reloadすると反映される
  void _listener(String message) => print('_listener: $message');

  @override
  void dispose() {
    _sc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Dog'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _sc.add('onPressed'),
      ),
    );
  }
}
