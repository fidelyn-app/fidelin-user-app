// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointDTO _$PointDTOFromJson(Map<String, dynamic> json) => PointDTO(
      id: json['id'] as String,
      used: json['used'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PointDTOToJson(PointDTO instance) => <String, dynamic>{
      'id': instance.id,
      'used': instance.used,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
