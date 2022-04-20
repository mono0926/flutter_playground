import 'package:flutter/material.dart';

import 'spreadsheet_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spreadsheet View')),
      body: SpreadsheetView(
        columnHeaderHeight: 40,
        rowHeaderWidth: 50,
        cellWidth: 80,
        cellHeight: 40,
        columnCount: 20,
        rowCount: 40,
        corner: const Placeholder(),
        columnHeaderBuilder: (context, i) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red[100],
            border: Border.all(),
          ),
          child: Text('Col $i'),
        ),
        rowHeaderBuilder: (context, i) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red[100],
            border: Border.all(),
          ),
          child: Text('Row $i'),
        ),
        cellBuilder: (context, row, column) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Text('$row-$column'),
          );
        },
        contentBuilder: (context, columnIndex, cellHeight, rowCount) {
          if (columnIndex == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: cellHeight * 1.5,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  height: cellHeight * 1.5,
                  color: Colors.amberAccent[200],
                  child: const Text('Hello'),
                ),
              ],
            );
          }
          if (columnIndex == 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: cellHeight * 4,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  height: cellHeight * 3,
                  color: Colors.blue[200],
                  child: const Text('Flutter'),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
