import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.network('https://mono0926.com/images/love_logo.png'),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return ColoredBox(
                color: Colors.blue[100]!,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
