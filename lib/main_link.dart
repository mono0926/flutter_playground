import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/next') {
          return MaterialPageRoute<dynamic>(
            builder: (context) => Scaffold(
              appBar: AppBar(),
            ),
            settings: settings,
          );
        }
        return null;
      },
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Link(
              uri: Uri.parse('https://mono0926.com'),
              builder: (context, followLink) => ElevatedButton(
                child: const Text('mono'),
                onPressed: followLink,
              ),
            ),
            Link(
              uri: Uri.parse('/next'),
              builder: (context, followLink) => ElevatedButton(
                child: const Text('next'),
                onPressed: followLink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
