import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_riverpod_generator.g.dart';

// ignore: avoid_classes_with_only_static_members
class Hoge {
  static final helloWorld = _helloWorldProvider;
}

@riverpod
String _helloWorld(_HelloWorldRef ref) {
  return 'Hello world';
}

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// ignore: lines_longer_than_80_chars
// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(Hoge.helloWorld);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}

@riverpod
Future<String> _monoProvider(
  _MonoProviderRef ref,
  String arg,
) {
  return Future.value('');
}
