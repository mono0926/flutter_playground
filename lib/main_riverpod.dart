import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      builder: (context, child) {
        return Consumer(
          (context, watch) {
            watch(themeProvider).state = Theme.of(context);
            return child;
          },
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
            context.read(_controller).foo();
          },
        ),
      ),
    );
  }
}

final _controller = Provider((ref) => _Controller(ref.read));

class _Controller {
  _Controller(this._read);
  final Reader _read;

  void foo() {
    print('brightness: ${_read(themeProvider).state.brightness}');
  }
}

final themeProvider = StateProvider<ThemeData>((ref) => null);
