import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

final countRepository = StateNotifierProvider<CountRepository, AsyncValue<int>>(
  (_) => CountRepository(),
);

class CountRepository extends StateNotifier<AsyncValue<int>> {
  CountRepository() : super(const AsyncValue.data(0));

  Future<void> increment() async {
    final count = state.data?.value;
    if (count == null) {
      return;
    }
    state = const AsyncValue.loading();
    // 更新時間中を適当に再現
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = AsyncValue.data(count + 1);
  }
}

final incrementer = Provider((ref) {
  // 関数内でのwatch実行はNG。
  // 関数返すProviderパターンが良いと思ったものの、
  // 素直に別クラスにした方がwatch呼び出しを確実に禁止できて良いかも
  final read = ref.read;
  return () => read(countRepository.notifier).increment();
});

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
