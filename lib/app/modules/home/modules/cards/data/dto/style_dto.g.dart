// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleDTO _$StyleDTOFromJson(Map<String, dynamic> json) => StyleDTO(
      id: json['id'] as String,
      pointColor: json['pointColor'] as String,
      pointShowNumbers: json['pointShowNumbers'] as bool,
      pointBorderSize: json['pointBorderSize'] as String,
      pointColumnSize: (json['pointColumnSize'] as num).toInt(),
      pointBorderRadius: json['pointBorderRadius'] as String,
      pointBackgroundUrl: json['pointBackgroundUrl'] as String?,
      backgroundUrl: json['backgroundUrl'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$StyleDTOToJson(StyleDTO instance) => <String, dynamic>{
      'id': instance.id,
      'pointColor': instance.pointColor,
      'pointShowNumbers': instance.pointShowNumbers,
      'pointBorderSize': instance.pointBorderSize,
      'pointColumnSize': instance.pointColumnSize,
      'pointBorderRadius': instance.pointBorderRadius,
      'pointBackgroundUrl': instance.pointBackgroundUrl,
      'backgroundUrl': instance.backgroundUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };
