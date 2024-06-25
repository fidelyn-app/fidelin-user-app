import 'package:fidelin_user_app/app/modules/home/data/data/dto/card_dto.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/store_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/style_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/card_entity.dart';

class CardMapper {
  static Card toEntity(CardDTO dto) {
    return Card(
      id: dto.id,
      maxPoints: dto.maxPoints,
      description: dto.description,
      active: dto.active,
      storeId: dto.storeId,
      timeToExpire: TimeToExpireMapper.toEntity(dto.timeToExpire),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      store: StoreMapper.toEntity(dto.store),
      style: StyleMapper.toEntity(dto.style),
    );
  }

  static CardDTO toDto(Card entity) {
    return CardDTO(
      id: entity.id,
      maxPoints: entity.maxPoints,
      description: entity.description,
      active: entity.active,
      storeId: entity.storeId,
      timeToExpire: TimeToExpireMapper.toDto(entity.timeToExpire),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      store: StoreMapper.toDto(entity.store),
      style: StyleMapper.toDto(entity.style),
    );
  }
}

class TimeToExpireMapper {
  static TimeToExpire toEntity(TimeToExpireDTO dto) {
    return TimeToExpire(
      years: dto.years,
      months: dto.months,
      days: dto.days,
      hours: dto.hours,
      minutes: dto.minutes,
      seconds: dto.seconds,
    );
  }

  static TimeToExpireDTO toDto(TimeToExpire entity) {
    return TimeToExpireDTO(
      years: entity.years,
      months: entity.months,
      days: entity.days,
      hours: entity.hours,
      minutes: entity.minutes,
      seconds: entity.seconds,
    );
  }
}
