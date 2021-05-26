import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'tile.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => DataListNotifier(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<DataListNotifier>(context, listen: false)
            .updateCurrentIndexUpdatedAt(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<DataListNotifier>(context);
    final dataList = notifier.value;
    return ListView.builder(
      itemBuilder: (context, index) {
        final data = dataList[index];
        // 通常はkeyも指定する(`key: ValueKey(index)`など)が、
        // このサンプルでは順序不変なためkey指定する理由がないため省略
        return ChangeNotifierProxyProvider<DataListNotifier, TileNotifier>(
          create: (context) => TileNotifier(data),
          update: (context, dataListNotifier, previous) =>
              previous!..value = dataListNotifier.value[previous.value.index],
          child: const Tile(),
        );
      },
    );
  }
}

class DataListNotifier extends ValueNotifier<List<Data>> {
  DataListNotifier() : super(Data.generateSamples());

  var _index = 0;

  // 一要素のupdatedAtだけ書き換えつつリスト全体の更新として通知
  void updateCurrentIndexUpdatedAt() {
    final list = List<Data>.from(value);
    list[_index] = list[_index].copyWith(updatedAt: DateTime.now());
    value = list;
    _index++;
  }
}
