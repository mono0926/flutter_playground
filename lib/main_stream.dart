import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final _sc = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();

    // printの中身を書き換えてからHot Reloadしても反映されない(Hot Restartで反映)
    _sc.stream.listen((message) => print('initState: $message'));
    _sc.stream.listen(_listener);
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
