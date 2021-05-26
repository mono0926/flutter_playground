import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => _Model(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    final ids = context.select((_Model model) => model.ids);
    return Scaffold(
      appBar: AppBar(),
      body: Wrap(
        children: ids
            .map(
              (id) => _Chip(
                key: ValueKey(id),
                id: id,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    print('_Chip build');
    return FilterChip(
      label: Text(id),
      // ignore: avoid_types_on_closure_parameters
      selected: context.select((_Model model) => model.isSelected(id)),
      // 型パラメーター指定なら良いが、2つの型明示が面倒(特に2つめが冗長)
//      selected: context.select<_Model, bool>((model) => model.isSelected(id)),
      onSelected: (selected) {
        final model = context.read<_Model>();
        selected ? model.select(id) : model.unselect(id);
      },
    );
  }
}

class _Model with ChangeNotifier {
  final _ids = List.generate(100, (index) => '$index');
  final _selectedIds = <String>{};

  List<String> get ids => UnmodifiableListView(_ids);

  bool isSelected(String id) => _selectedIds.contains(id);

  void select(String id) {
    _selectedIds.add(id);
    notifyListeners();
  }

  void unselect(String id) {
    _selectedIds.remove(id);
    notifyListeners();
  }
}
