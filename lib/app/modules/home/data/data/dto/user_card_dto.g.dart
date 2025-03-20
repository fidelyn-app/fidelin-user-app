// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCardDTO _$UserCardDTOFromJson(Map<String, dynamic> json) => UserCardDTO(
      id: json['id'] as String,
      expiration: DateTime.parse(json['expiration'] as String),
      pointsCount: (json['pointsCount'] as num).toInt(),
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      card: UserCardDTO._cardFromJson(json['card'] as Map<String, dynamic>),
      points: UserCardDTO._pointsFromJson(json['points'] as List),
    );

Map<String, dynamic> _$UserCardDTOToJson(UserCardDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiration': instance.expiration.toIso8601String(),
      'pointsCount': instance.pointsCount,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'card': UserCardDTO._cardToJson(instance.card),
      'points': UserCardDTO._pointsToJson(instance.points),
    };
