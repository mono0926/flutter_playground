import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

final navigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

final countState = StateNotifierProvider<CountRepository, AsyncValue<int>>(
  (_) => CountRepository(),
);

class CountRepository extends StateNotifier<AsyncValue<int>> {
  CountRepository() : super(const AsyncValue.loading()) {
    Future(() async {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      state = const AsyncValue.data(0);
    });
  }

  final _history = <int>[];

  Future<void> increment() async {
    final value = state.asData?.value;
    if (value == null) {
      return;
    }
    state = const AsyncValue.loading();
    // 更新時間中を適当に再現
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = AsyncValue.data(value + 1);
  }

  Future<void> undo() async {
    state = await AsyncValue.guard(() async {
      return (_history..removeLast()).last;
    });
  }

  @override
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

final isLoading = Provider((ref) => ref.watch(countState) is AsyncLoading);

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              ref.watch(countMessage),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: ref.watch(isLoading)
          ? null
          : FloatingActionButton(
              onPressed: () => ref.read(incrementer)(),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
    );
  }
}
