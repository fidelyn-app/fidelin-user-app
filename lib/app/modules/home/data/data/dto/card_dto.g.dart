// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDTO _$CardDTOFromJson(Map<String, dynamic> json) => CardDTO(
      id: json['id'] as String,
      maxPoints: (json['maxPoints'] as num).toInt(),
      color: json['color'] as String?,
      description: json['description'] as String,
      active: json['active'] as bool,
      storeId: json['storeId'] as String,
      timeToExpire: CardDTO._timeToExpireFromJson(
          json['timeToExpire'] as Map<String, dynamic>?),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      store: CardDTO._storeFromJson(json['store'] as Map<String, dynamic>),
      style: CardDTO._styleFromJson(json['style'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CardDTOToJson(CardDTO instance) => <String, dynamic>{
      'id': instance.id,
      'maxPoints': instance.maxPoints,
      'color': instance.color,
      'description': instance.description,
      'active': instance.active,
      'storeId': instance.storeId,
      'timeToExpire': CardDTO._timeToExpireToJson(instance.timeToExpire),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'store': CardDTO._storeToJson(instance.store),
      'style': CardDTO._styleToJson(instance.style),
    };

TimeToExpireDTO _$TimeToExpireDTOFromJson(Map<String, dynamic> json) =>
    TimeToExpireDTO(
      years: (json['years'] as num?)?.toInt(),
      months: (json['months'] as num?)?.toInt(),
      days: (json['days'] as num?)?.toInt(),
      hours: (json['hours'] as num?)?.toInt(),
      minutes: (json['minutes'] as num?)?.toInt(),
      seconds: (json['seconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimeToExpireDTOToJson(TimeToExpireDTO instance) =>
    <String, dynamic>{
      'years': instance.years,
      'months': instance.months,
      'days': instance.days,
      'hours': instance.hours,
      'minutes': instance.minutes,
      'seconds': instance.seconds,
    };
