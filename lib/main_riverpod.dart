import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, child) {
            ref.watch(themeProvider.notifier).update((_) => Theme.of(context));
            return child!;
          },
        );
      },
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(_controller).foo();
          },
          child: const Text('Dog'),
        ),
      ),
    );
  }
}

final _controller = Provider(_Controller.new);

class _Controller {
  _Controller(this._ref);
  final Ref _ref;

  void foo() {
    print('brightness: ${_ref.read(themeProvider)!.brightness}');
  }
}

final themeProvider = StateProvider<ThemeData?>((ref) => null);
