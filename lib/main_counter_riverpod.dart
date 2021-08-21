import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

final navigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

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

final countRepository = StateNotifierProvider<CountRepository, AsyncValue<int>>(
  (_) => CountRepository(),
);

class CountRepository extends StateNotifier<AsyncValue<int>> {
  CountRepository() : super(AsyncValue.data(0));

  final _history = <int>[0];

  Future<void> increment() async {
    final value = state.data?.value;
    if (value == null) {
      return;
    }
    state = const AsyncValue.loading();
    // 更新時間中を適当に再現
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final nextValue = value + 1;
    _history.add(nextValue);
    state = AsyncValue.data(nextValue);
  }

  Future<void> undo() async {
    state = await AsyncValue.guard(() async {
      _history.removeLast();
      return _history.last;
    });
  }
}

final incrementer = Provider((ref) {
  // 関数内でのwatch実行はNG。
  // この関数返すProviderパターンが良さそうと思ったものの、
  // 素直に別クラスにした方がwatch呼び出しを確実に禁止できて良いかも
  final read = ref.read;
  return () async {
    await read(countRepository.notifier).increment();
    read(incrementedSnackBarPresenter)();
  };
});

final incrementedSnackBarPresenter = Provider(
  (ref) {
    final read = ref.read;
    return () {
      ScaffoldMessenger.of(read(navigatorKey).currentContext!)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Incremented to ${read(countRepository).data?.value ?? 0}',
            ),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () => read(countRepository.notifier).undo(),
            ),
          ),
        );
    };
  },
);

final isLoading = Provider(
  (ref) => ref.watch(countRepository) is AsyncLoading,
);

final countMessage = Provider(
  (ref) => 'Count: ${ref.watch(countRepository).maybeWhen(
        data: (count) => '$count',
        orElse: () => '?',
      )}',
);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
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
