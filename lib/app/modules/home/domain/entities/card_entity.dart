import 'store_entity.dart';
import 'style_entity.dart';

class Card {
  final String id;
  final int maxPoints;
  final String description;
  final bool active;
  final String storeId;
  final TimeToExpire? timeToExpire;
  final DateTime createdAt;
  final DateTime updatedAt;

  final Store store;
  final Style style;

  Card({
    required this.id,
    required this.maxPoints,
    required this.description,
    required this.active,
    required this.storeId,
    required this.timeToExpire,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
    required this.style,
  });

  @override
  String toString() {
    return '''
      Card(
        id: $id,
        maxPoints: $maxPoints,
        description: $description,
        active: $active,
        storeId: $storeId,
        timeToExpire: $timeToExpire,
        createdAt: $createdAt,
        updatedAt: $updatedAt,
        store: ${store.toString()}
        style: ${style.toString()}
      )
      ''';
  }
}

class TimeToExpire {
  final int? years;
  final int? months;
  final int? days;
  final int? hours;
  final int? minutes;
  final int? seconds;

  TimeToExpire({
    this.years,
    this.months,
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });
}
