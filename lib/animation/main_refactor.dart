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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _isVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: _isVisible,
            builder: (context, isVisible, child) {
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
                tween: Tween<double>(end: isVisible ? 1 : 0),
                builder: (context, value, child) => Visibility(
                  visible: value == 0,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: value,
                      child: child,
                    ),
                  ),
                ),
                child: MaterialBanner(
                  content: const Text('This is a banner. Dismiss me'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async => _isVisible.value = false,
                      child: const Text('DISMISS'),
                    ),
                  ],
                ),
              );
            },
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
