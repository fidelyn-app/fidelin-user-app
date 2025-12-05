// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardDTO _$RewardDTOFromJson(Map<String, dynamic> json) => RewardDTO(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  pointsRequired: (json['pointsRequired'] as num).toInt(),
  expirationModel: json['expirationModel'] as String,
  timeToExpire:
      json['timeToExpire'] == null
          ? null
          : TimeToExpireDTO.fromJson(
            json['timeToExpire'] as Map<String, dynamic>,
          ),
  dateToExpire:
      json['dateToExpire'] == null
          ? null
          : DateTime.parse(json['dateToExpire'] as String),
  storeId: json['storeId'] as String,
);

Map<String, dynamic> _$RewardDTOToJson(RewardDTO instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'pointsRequired': instance.pointsRequired,
  'expirationModel': instance.expirationModel,
  'timeToExpire': instance.timeToExpire,
  'dateToExpire': instance.dateToExpire?.toIso8601String(),
  'storeId': instance.storeId,
};
