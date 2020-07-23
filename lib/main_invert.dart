import 'package:flutter/material.dart';

void main() {
  debugInvertOversizedImages = true;
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 80, // 120
          height: 80, // 120
          child: Image.network(
            'https://mono0926.com/images/love_logo.png',
//            cacheHeight: 80,
//            cacheWidth: 80,
          ),
        ),
      ),
    );
  }
}
