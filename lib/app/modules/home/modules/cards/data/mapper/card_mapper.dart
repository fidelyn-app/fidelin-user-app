import 'package:fidelin_user_app/app/modules/home/modules/cards/data/dto/card_dto.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/mapper/store_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/card_entity.dart';
import 'package:fidelin_user_app/utils/color_mapper.dart';
import 'package:flutter/material.dart' as Material;

class CardMapper {
  static Card toEntity(CardDTO dto) {
    return Card(
      id: dto.id,
      backgroundUrl: dto.backgroundUrl,
      maxPoints: dto.maxPoints,
      color: dto.color != null
          ? ColorMapper.hexToColor(dto.color!)
          : Material.Colors.grey,
      description: dto.description,
      active: dto.active,
      storeId: dto.storeId,
      timeToExpire: TimeToExpireMapper.toEntity(dto.timeToExpire),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      store: StoreMapper.toEntity(dto.store),
    );
  }

  static CardDTO toDto(Card entity) {
    return CardDTO(
      id: entity.id,
      backgroundUrl: entity.backgroundUrl,
      maxPoints: entity.maxPoints,
      color: ColorMapper.colorToHex(entity.color),
      description: entity.description,
      active: entity.active,
      storeId: entity.storeId,
      timeToExpire: TimeToExpireMapper.toDto(entity.timeToExpire),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      store: StoreMapper.toDto(entity.store),
    );
  }
}

class TimeToExpireMapper {
  static TimeToExpire toEntity(TimeToExpireDTO dto) {
    return TimeToExpire(
      months: dto.months,
    );
  }

  static TimeToExpireDTO toDto(TimeToExpire entity) {
    return TimeToExpireDTO(
      months: entity.months,
    );
  }
}
