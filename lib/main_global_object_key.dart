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
          // GlobalKey()なのでsetState後に初期化される
          Key1(),
          // GlobalObjectKey(context)なのでリビルド前後で同一だと見なされてStateは保持
          Key2(),
          // indexとruntimeTypeが同じなのでStateは保持
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

class Key1 extends StatelessWidget {
  const Key1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Counter(
      key: GlobalKey(),
      label: 'GlobalKey',
    );
  }
}

class Key2 extends StatelessWidget {
  const Key2({Key key}) : super(key: key);
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
