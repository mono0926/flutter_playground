/// Flutter code sample for Table

// This sample shows a `Table` with borders, multiple types of column widths and
// different vertical cell alignments.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text('AAA'),
              ),
            ),
            Container(
              height: 32,
              color: Colors.red,
            ),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 50),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('AAA' * 3),
              ),
            ),
            Container(
              height: 64,
              color: Colors.yellow,
            ),
          ],
        ),
      ],
    );
  }
}
