import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class Tile extends StatelessWidget {
  const Tile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TileNotifier>(context);
    final data = notifier.value;
    print('build($data)');
    return ListTile(
      title: Text('${data.index}'),
      subtitle: Row(
        children: <Widget>[
          Text('Created At: ${DateFormat.Hms().format(data.createdAt)}'),
          const SizedBox(width: 16),
          Text('Updated At: ${DateFormat.Hms().format(data.updatedAt)}'),
        ],
      ),
    );
  }
}

class TileNotifier extends ValueNotifier<Data> {
  TileNotifier(super.value);
}
