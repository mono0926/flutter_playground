import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bidirectional Scroll Page')),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key key}) : super(key: key);
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final _verticalScrollReceiver = ScrollController();
  final _verticalScrollSender = ScrollController();
  final _horizontalScrollReceiver = ScrollController();
  final _horizontalScrollSender = ScrollController();

  static const _cellWidth = 80.0;
  static const _cellHeight = 60.0;
  static const _axisWidth = 40.0;
  static const _colCount = 20;
  static const _rowCount = 40;

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
          height: _axisWidth,
          child: Row(
            children: <Widget>[
              _buildCorner(),
              Expanded(
                child: _buildXLabels(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              SizedBox(
                child: _buildYLabels(),
                width: _axisWidth,
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
    return Container(
      width: _axisWidth,
      color: Colors.grey,
    );
  }

  Widget _buildXLabels() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: _horizontalScrollSender,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _colCount,
      itemBuilder: (context, index) => const Placeholder(
        fallbackWidth: _cellWidth,
        color: Colors.red,
      ),
    );
  }

  Widget _buildYLabels() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: _verticalScrollSender,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _rowCount,
      itemBuilder: (context, index) => const Placeholder(
        fallbackHeight: _cellHeight,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildGrid() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _verticalScrollReceiver,
      child: SizedBox(
        height: _cellHeight * _rowCount,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _horizontalScrollReceiver,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _colCount,
          itemBuilder: (context, index) => SizedBox(
            width: _cellWidth,
            // TODO(mono): Not lazy loaded
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _rowCount,
              itemBuilder: (context, index) => const Placeholder(
                fallbackHeight: _cellHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
