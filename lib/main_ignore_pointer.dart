import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Dog'),
            ),
          ),
        ),
        IgnorePointer(
          child: ColoredBox(
            color: Colors.red.withOpacity(0.3),
            child: const Center(
              child: Text('(　´･‿･｀)'),
            ),
          ),
        )
      ],
    );
  }
}
