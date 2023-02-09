import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider(create: (context) => SomeService1()),
          Provider(
            create: (context) => SomeService2(
              locator: context.read,
            ),
            // If uncomment `lazy: false`, error occurs:
            // 'package:provider/src/provider.dart': Failed assertion: line 427 pos 12: '!debugDoingBuild &&
            // !_debugIsInInheritedProviderUpdate': is not true.
//          lazy: false,
          ),
        ],
        child: const App(),
      ),
    );

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
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.watch<_Notifier>().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SomeService1 {}

class SomeService2 {
  SomeService2({
    required Locator locator,
  }) {
    print(locator<SomeService1>());
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
