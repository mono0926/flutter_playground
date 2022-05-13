import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _isVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isVisible,
            builder: (context, isVisible, child) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
                child: Align(
                  heightFactor: isVisible ? 1 : 0,
                  child: child,
                ),
              );
            },
            child: MaterialBanner(
              content: const Text('This is a banner. Dismiss me'),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    _isVisible.value = false;
                  },
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            color: Colors.blue,
            child: const Text('A Container'),
          ),
        ],
      ),
    );
  }
}
