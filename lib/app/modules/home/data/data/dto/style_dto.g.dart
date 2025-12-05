// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleDTO _$StyleDTOFromJson(Map<String, dynamic> json) => StyleDTO(
  id: json['id'] as String,
  colorPrimary: json['colorPrimary'] as String,
  colorSecondary: json['colorSecondary'] as String,
  pointShowNumbers:
      json['pointShowNumbers'] == null
          ? false
          : StyleDTO._toBool(json['pointShowNumbers']),
  pointBorderRadius:
      json['pointBorderRadius'] == null
          ? 5.0
          : StyleDTO._toDouble(json['pointBorderRadius']),
  pointBackgroundUrl: json['pointBackgroundUrl'] as String?,
  backgroundUrl: json['backgroundUrl'] as String?,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
);

Map<String, dynamic> _$StyleDTOToJson(StyleDTO instance) => <String, dynamic>{
  'id': instance.id,
  'colorPrimary': instance.colorPrimary,
  'colorSecondary': instance.colorSecondary,
  'pointShowNumbers': StyleDTO._fromBool(instance.pointShowNumbers),
  'pointBorderRadius': StyleDTO._fromDouble(instance.pointBorderRadius),
  'pointBackgroundUrl': instance.pointBackgroundUrl,
  'backgroundUrl': instance.backgroundUrl,
  'title': instance.title,
  'subtitle': instance.subtitle,
};
