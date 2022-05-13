import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        create: (context) => _Controller(context.read),
        child: const HomePage(),
      ),
      builder: (context, child) {
        return Provider.value(
          value: Theme.of(context),
          child: child,
        );
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
        child: ElevatedButton(
          onPressed: () {
            context.read<_Controller>().foo();
          },
          child: const Text('Dog'),
        ),
      ),
    );
  }
}

class _Controller {
  _Controller(this._read);

  final Locator _read;

  void foo() {
    print('brightness: ${_read<ThemeData>().brightness}');
  }
}
