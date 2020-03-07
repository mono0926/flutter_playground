import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';

part 'main_state_notifier.freezed.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StateNotifierProvider<_Controller, Counter>(
        create: (context) => _Controller(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // エラーが出るのでとりあえず.of()にしてる
    // Failed assertion: line 427 pos 12: '!debugDoingBuild && !_debugIsInInheritedProviderUpdate': is not true.
    final controller = Provider.of<_Controller>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Text('${context.select((Counter c) => c.count)}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}

class _Controller extends StateNotifier<Counter> {
  _Controller() : super(const Counter(count: 0));

  void increment() => state = state.copyWith(
        count: state.count + 1,
      );
}

@freezed
abstract class Counter with _$Counter {
  const factory Counter({@required int count}) = _Counter;
}
