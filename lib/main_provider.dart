import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

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
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: const Text('Dog'),
          onPressed: () {
            context.read<_Controller>().foo();
          },
        ),
      ),
    );
  }
}

class _Controller {
  _Controller(this._read);

  Locator _read;

  void foo() {
    print('brightness: ${_read<ThemeData>().brightness}');
  }
}
