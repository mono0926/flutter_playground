import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _counter = ChangeNotifierProvider((ref) => Counter());

class Counter with ChangeNotifier {
  var _count = C();
  C get count => _count;

  void increment() {
    _count.value++;
    notifyListeners();
  }
}

class C {
  int value = 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is C && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

void main() => runApp(const ProviderScope(child: App()));

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
            Text(useProvider(_counter.select((s) => s.count)).value.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(_counter).increment();
        },
      ),
    );
  }
}

@immutable
class Person {
  const Person({
    @required this.name,
    @required this.age,
  });
  final String name;
  final int age;

  Person copyWith({
    String name,
    int age,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}

void f() {
  const p1 = Person(name: 'mono', age: 33);
  final p2 = p1.copyWith(age: p1.age + 1);
}
