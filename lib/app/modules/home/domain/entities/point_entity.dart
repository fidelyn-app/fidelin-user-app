class Point {
  final String id;
  final bool used;
  final DateTime createdAt;
  final DateTime updatedAt;

  Point({
    required this.id,
    required this.used,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return '''
    Store(
      id: $id,
      used: $used,
      createdAt: $createdAt,
      updatedAt: $updatedAt
    )
   ''';
  }
}
