import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';

part 'main_state_notifier2.freezed.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          StateNotifierProvider<_Controller1, Counter1>(
            create: (context) => _Controller1(),
          ),
          StateNotifierProvider<_Controller2, Counter2>(
            create: (context) => _Controller2(),
          ),
        ],
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
          '${context.select((Counter2 c) => c.count)}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<_Controller2>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Controller1 extends StateNotifier<Counter1> {
  _Controller1() : super(const Counter1(count: 0));

  void increment() => state = state.copyWith(
        count: state.count + 1,
      );
}

@freezed
abstract class Counter1 with _$Counter1 {
  const factory Counter1({required int count}) = _Counter1;
}

class _Controller2 extends StateNotifier<Counter2> with LocatorMixin {
  _Controller2() : super(const Counter2(count: 0));

  void increment() => state = state.copyWith(
        count: state.count + 1,
      );

  @override
  void update(T Function<T>() watch) {
    // If uncomment this, error occurs:
    // 'package:provider/src/provider.dart': Failed assertion: line 427 pos 12: '!debugDoingBuild && !_debugIsInInheritedProviderUpdate': is not true.
//    final counter1 = watch<Counter1>();
//    print(counter1);

    // OK:
    final controller1 = watch<_Controller1>();
    print(controller1);
  }
}

@freezed
abstract class Counter2 with _$Counter2 {
  const factory Counter2({required int count}) = _Counter2;
}
