class Data {
  Data({
    required this.index,
    required this.createdAt,
    required this.updatedAt,
  });

  final int index;
  final DateTime createdAt;
  final DateTime updatedAt;

  static List<Data> generateSamples() {
    final now = DateTime.now();
    return List.generate(
      100,
      (i) => Data(
        index: i,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Data copyWith({DateTime? updatedAt}) => Data(
        index: index,
        createdAt: createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  String toString() {
    return 'Data{index: $index, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
