import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
//        body: MyWidget(),
      body: ListView(
        // 通常はconstにするがそれだとリビルドが伝播せず今回の説明に不都合なので無指定
        children: [
          // リビルドごとGlobalKey()が毎回再生成され前後のkey不合致になり、Stateごと再生成される
          GlobalKeyWidget(),
          // GlobalObjectKey(context)なのでリビルド前後でkeyが同一だと見なされてStateは維持
          GlobalObjectKeyWidget(),
          // indexとruntimeTypeが同じなのでStateは維持
          Counter(label: 'Counter'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class GlobalKeyWidget extends StatelessWidget {
  const GlobalKeyWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Counter(
      key: GlobalKey(),
      label: 'GlobalKey',
    );
  }
}

class GlobalObjectKeyWidget extends StatelessWidget {
  const GlobalObjectKeyWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Counter(
      key: GlobalObjectKey(context),
      label: 'GlobalObjectKey(context)',
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$_count'),
      subtitle: Text(widget.label),
      onTap: () {
        setState(() {
          _count++;
        });
      },
    );
  }
}
