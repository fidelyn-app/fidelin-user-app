import 'package:fidelin_user_app/app/modules/home/data/data/dto/reward_dto.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/card_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/reward_entity.dart';

class RewardMapper {
  static Reward toEntity(RewardDTO dto) {
    return Reward(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      pointsRequired: dto.pointsRequired,
      expirationModel: ExpirationModelEnum.values.firstWhere(
        (e) => e.name == dto.expirationModel,
        orElse: () => ExpirationModelEnum.NONE,
      ),
      timeToExpire:
          dto.timeToExpire == null
              ? null
              : TimeToExpireMapper.toEntity(dto.timeToExpire!),
      dateToExpire: dto.dateToExpire,
      storeId: dto.storeId,
      active: dto.active,
    );
  }

  static RewardDTO toDto(Reward entity) {
    return RewardDTO(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      pointsRequired: entity.pointsRequired,
      expirationModel: entity.expirationModel.name,
      timeToExpire:
          entity.timeToExpire == null
              ? null
              : TimeToExpireMapper.toDto(entity.timeToExpire!),
      dateToExpire: entity.dateToExpire,
      storeId: entity.storeId,
      active: entity.active,
    );
  }
}
