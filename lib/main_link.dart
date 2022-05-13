import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

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
  const HomePage({super.key});
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
                onPressed: followLink,
                child: const Text('mono'),
              ),
            ),
            Link(
              uri: Uri.parse('/next'),
              builder: (context, followLink) => ElevatedButton(
                onPressed: followLink,
                child: const Text('next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
