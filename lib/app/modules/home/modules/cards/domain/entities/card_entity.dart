import 'store_entity.dart';

class Card {
  final String id;
  final String? backgroundUrl;
  final int maxPoints;
  final String color;
  final String description;
  final bool active;
  final String storeId;
  final TimeToExpire timeToExpire;
  final DateTime createdAt;
  final DateTime updatedAt;

  final Store store;

  Card({
    required this.id,
    this.backgroundUrl,
    required this.maxPoints,
    required this.color,
    required this.description,
    required this.active,
    required this.storeId,
    required this.timeToExpire,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
  });

  @override
  String toString() {
    return '''
      Card(
        id: $id,
        backgroundUrl: $backgroundUrl,
        maxPoints: $maxPoints,
        color: $color,
        description: $description,
        active: $active,
        storeId: $storeId,
        timeToExpire: $timeToExpire,
        createdAt: $createdAt,
        updatedAt: $updatedAt,
        store: ${store.toString()}
      )
      ''';
  }
}

class TimeToExpire {
  final int months;

  TimeToExpire({
    required this.months,
  });
}
