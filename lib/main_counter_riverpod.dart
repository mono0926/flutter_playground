import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const App(),
    );

final navigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: ref.watch(navigatorKey),
      home: const HomePage(),
      theme: ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()).copyWith(
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
    );
  }
}

final countState =
    AsyncNotifierProvider<CountRepository, int>(CountRepository.new);

class CountRepository extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    // 更新時間中を適当に再現
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return 0;
  }

  final _history = <int>[];

  Future<void> increment() async {
    await update((value) async {
      state =
          const AsyncValue<int>.loading().copyWithPrevious(AsyncData(value));
      // 更新時間中を適当に再現
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return value + 1;
    });
  }

  Future<void> undo() async {
    await update((p0) => (_history..removeLast()).last);
  }

  @override
  @protected
  set state(AsyncValue<int> value) {
    value.whenData(_history.add);
    super.state = value;
  }
}

final incrementer = Provider(Incrementer.new);

class Incrementer {
  Incrementer(this._ref);
  final Ref _ref;

  Future<void> call() async {
    await _ref.read(countState.notifier).increment();
    _ref.read(incrementedSnackBarPresenter)();
  }
}

final incrementedSnackBarPresenter = Provider(
  IncrementedSnackBarPresenter.new,
);

class IncrementedSnackBarPresenter {
  IncrementedSnackBarPresenter(this._ref);

  final Ref _ref;

  void call() {
    ScaffoldMessenger.of(_ref.read(navigatorKey).currentContext!)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Incremented to ${_ref.read(countState).asData?.value ?? 0}',
          ),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () => _ref.read(countState.notifier).undo(),
          ),
        ),
      );
  }
}

final isLoadingProvider = Provider((ref) => ref.watch(countState).isLoading);

final countMessage = Provider(
  (ref) => 'Count: ${ref.watch(countState).maybeWhen(
        data: (count) => '$count',
        orElse: () => '?',
      )}',
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Opacity(
              opacity: isLoading ? 0.5 : 1,
              child: Text(
                ref.watch(countMessage),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isLoading
          ? null
          : FloatingActionButton(
              onPressed: () => ref.read(incrementer)(),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
    );
  }
}
