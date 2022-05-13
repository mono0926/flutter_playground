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

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              color: Colors.red,
            ),
//          SizedBox(height: 10),
            const LimitedBox(
              maxHeight: 30,
            ),
            Container(
              height: 100,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
