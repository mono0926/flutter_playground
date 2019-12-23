//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

typedef HeaderBuilder = Widget Function(BuildContext context, int index);
typedef CellBuilder = Widget Function(
  BuildContext context,
  int row,
  int column,
);
typedef ContentBuilder = Widget Function(
  BuildContext context,
  int columnIndex,
  double cellHeight,
  int rowCount,
);

class SpreadsheetView extends StatefulWidget {
  const SpreadsheetView({
    Key key,
    @required this.corner,
    @required this.columnHeaderBuilder,
    @required this.rowHeaderBuilder,
    @required this.cellBuilder,
    @required this.contentBuilder,
    @required this.columnHeaderHeight,
    @required this.rowHeaderWidth,
    @required this.cellWidth,
    @required this.cellHeight,
    @required this.columnCount,
    @required this.rowCount,
  }) : super(key: key);

  final Widget corner;
  final HeaderBuilder columnHeaderBuilder;
  final HeaderBuilder rowHeaderBuilder;
  final CellBuilder cellBuilder;
  final ContentBuilder contentBuilder;
  final double columnHeaderHeight;
  final double rowHeaderWidth;
  final double cellWidth;
  final double cellHeight;
  final int columnCount;
  final int rowCount;

  @override
  _SpreadsheetViewState createState() => _SpreadsheetViewState();
}

class _SpreadsheetViewState extends State<SpreadsheetView> {
  final _verticalScrollReceiver = ScrollController();
  final _verticalScrollSender = ScrollController();
  final _horizontalScrollReceiver = ScrollController();
  final _horizontalScrollSender = ScrollController();

  @override
  void initState() {
    super.initState();
    _verticalScrollReceiver.addListener(_updateAxisVerticalOffset);
    _horizontalScrollReceiver.addListener(_updateAxisHorizontalOffset);
  }

  @override
  void dispose() {
    _verticalScrollReceiver.removeListener(_updateAxisVerticalOffset);
    _horizontalScrollReceiver.removeListener(_updateAxisHorizontalOffset);
    super.dispose();
  }

  void _updateAxisVerticalOffset() {
    _verticalScrollSender.jumpTo(_verticalScrollReceiver.offset);
  }

  void _updateAxisHorizontalOffset() {
    _horizontalScrollSender.jumpTo(_horizontalScrollReceiver.offset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: widget.columnHeaderHeight,
          child: Row(
            children: <Widget>[
              _buildCorner(),
              Expanded(
                child: _buildColumnLabels(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              SizedBox(
                child: _buildRowLabels(),
                width: widget.rowHeaderWidth,
              ),
              Expanded(
                child: _buildGrid(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCorner() {
    return SizedBox(
      width: widget.rowHeaderWidth,
      child: widget.corner,
    );
  }

  Widget _buildColumnLabels() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _horizontalScrollSender,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.columnCount,
      itemBuilder: (context, index) => SizedBox(
        width: widget.cellWidth,
        child: widget.columnHeaderBuilder(context, index),
      ),
    );
  }

  Widget _buildRowLabels() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: _verticalScrollSender,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.rowCount,
      itemBuilder: (context, index) => SizedBox(
        height: widget.cellHeight,
        child: widget.rowHeaderBuilder(context, index),
      ),
    );
  }

  Widget _buildGrid() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _verticalScrollReceiver,
      child: SizedBox(
        height: widget.cellHeight * widget.rowCount,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _horizontalScrollReceiver,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widget.columnCount,
          itemBuilder: (context, column) => SizedBox(
            width: widget.cellWidth,
            child: Stack(
              children: <Widget>[
                Column(
                  children: List.generate(
                    widget.rowCount,
                    (row) => SizedBox(
                      height: widget.cellHeight,
                      child: widget.cellBuilder(context, row, column),
                    ),
                  ),
                ),
                widget.contentBuilder(
                  context,
                  column,
                  widget.cellHeight,
                  widget.rowCount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
