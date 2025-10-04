class Point {
  final String id;
  final bool used;

  Point({required this.id, required this.used});

  @override
  String toString() {
    return '''
    Store(
      id: $id,
      used: $used,
    )
   ''';
  }
}
