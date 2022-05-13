import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => _Notifier(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${context.select((_Notifier n) => n.count)}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.watch<_Notifier>().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Notifier extends ChangeNotifier {
  _Notifier();

  var _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
