import 'package:fidelin_user_app/app/modules/home/domain/entities/reward_entity.dart';

import 'card_entity.dart';
import 'point_entity.dart';

class UserCard {
  final String id;
  final DateTime? expiration;
  final int pointsCount;
  final String userId;
  final String shortCode;

  final Card card;
  final List<Point> points;
  final Reward reward;

  UserCard({
    required this.id,
    required this.expiration,
    required this.pointsCount,
    required this.userId,
    required this.card,
    required this.points,
    required this.shortCode,
    required this.reward,
  });

  @override
  String toString() {
    return '''
      UserCard(
        id: $id,
        expiration: $expiration,
        pointsCount: $pointsCount,
        shortCode $shortCode,
        reward: ${reward.toString()},
        card: ${card.toString()},
        points: ${points.map((point) => point.toString())} points (details omitted for brevity)
      )
      ''';
  }
}
