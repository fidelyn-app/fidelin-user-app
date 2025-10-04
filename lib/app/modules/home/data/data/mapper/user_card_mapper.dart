import 'package:fidelin_user_app/app/modules/home/data/data/mapper/card_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/point_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/reward_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';

import '../dto/user_card_dto.dart';

class UserCardMapper {
  static UserCard toEntity(UserCardDTO dto) {
    return UserCard(
      id: dto.id,
      expiration: dto.expiration,
      pointsCount: dto.pointsCount,
      userId: dto.userId,
      card: CardMapper.toEntity(dto.card), // Assuming CardMapper exists
      points:
          dto.points.map((pointDTO) => PointMapper.toEntity(pointDTO)).toList(),
      shortCode: dto.shortCode,
      reward: RewardMapper.toEntity(dto.reward),
    );
  }

  static UserCardDTO toDto(UserCard entity) {
    return UserCardDTO(
      id: entity.id,
      expiration: entity.expiration,
      pointsCount: entity.pointsCount,
      userId: entity.userId,
      card: CardMapper.toDto(entity.card), // Assuming CardMapper exists
      points: entity.points.map((point) => PointMapper.toDto(point)).toList(),
      shortCode: entity.shortCode,
      reward: RewardMapper.toDto(entity.reward),
    );
  }
}
