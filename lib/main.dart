import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
//        body: MyWidget(),
        body: const Center(
          child: Text('A'),
        ),
      ),
    );
  }
}

class MyWidget extends SingleChildRenderObjectWidget {
  const MyWidget({Key key})
      : super(
          key: key,
          child: const Text(
            'MyWidget',
            style: TextStyle(fontSize: 48),
          ),
        );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPositionedBox(
      alignment: Alignment.centerRight,
      textDirection: Directionality.of(context),
    );
  }
}
