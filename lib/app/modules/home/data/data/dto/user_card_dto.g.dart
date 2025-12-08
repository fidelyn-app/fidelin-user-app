// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCardDTO _$UserCardDTOFromJson(Map<String, dynamic> json) => UserCardDTO(
  id: json['id'] as String,
  expiration:
      json['expiration'] == null
          ? null
          : DateTime.parse(json['expiration'] as String),
  pointsCount: (json['pointsCount'] as num).toInt(),
  userId: json['userId'] as String,
  card: UserCardDTO._cardFromJson(json['card'] as Map<String, dynamic>),
  points: UserCardDTO._pointsFromJson(json['points'] as List),
  shortCode: json['shortCode'] as String?,
  reward: UserCardDTO._rewardFromJson(json['reward'] as Map<String, dynamic>),
  status: json['status'] as String,
);

Map<String, dynamic> _$UserCardDTOToJson(UserCardDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiration': instance.expiration?.toIso8601String(),
      'pointsCount': instance.pointsCount,
      'userId': instance.userId,
      'shortCode': instance.shortCode,
      'status': instance.status,
      'card': UserCardDTO._cardToJson(instance.card),
      'points': UserCardDTO._pointsToJson(instance.points),
      'reward': UserCardDTO._rewardToJson(instance.reward),
    };
