import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        dividerColor: Colors.red,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divider Page'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 0.5 / MediaQuery.of(context).devicePixelRatio),
          const Divider(), // 1 pixel
          const Divider(thickness: 0), // 1 pixel
          Divider(
            thickness: 1 / MediaQuery.of(context).devicePixelRatio,
          ), // 1 pixel
          const Divider(thickness: 1), // 1 point(端末によるがiPhone Xだと3 pixel)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0, // 線は消えずに1 pixel
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border(
                // staticメソッドも公開されている
                bottom: Divider.createBorderSide(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
