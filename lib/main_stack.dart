import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const _imagePath = 'assets/images/love.jpg';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: Colors.grey[300],
            child: const _MyImage_Stack(),
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _MyImage_Stack extends StatelessWidget {
  const _MyImage_Stack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fitのデフォルト: loose
      fit: StackFit.passthrough,
      children: [
        Image.asset(
          _imagePath,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

// ignore: unused_element
class _MyImage extends StatelessWidget {
  const _MyImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _imagePath,
      fit: BoxFit.cover,
    );
  }
}
