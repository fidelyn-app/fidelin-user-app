import 'card_entity.dart';
import 'point_entity.dart';

class UserCard {
  final String id;
  final DateTime expiration;
  final int pointsCount;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final Card card;
  final List<Point> points;

  UserCard({
    required this.id,
    required this.expiration,
    required this.pointsCount,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.card,
    required this.points,
  });

  @override
  String toString() {
    return '''
      UserCard(
        id: $id,
        expiration: $expiration,
        pointsCount: $pointsCount,
        userId: $userId,
        createdAt: $createdAt,
        updatedAt: $updatedAt,
        card: ${card.toString()},
        points: ${points.map((point) => point.toString())} points (details omitted for brevity)
      )
      ''';
  }
}
