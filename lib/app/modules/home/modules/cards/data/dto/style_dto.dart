import 'package:json_annotation/json_annotation.dart';

part 'style_dto.g.dart';

@JsonSerializable()
class StyleDTO {
  final String id;
  final String pointColor;
  final bool pointShowNumbers;
  final String pointBorderSize;
  final int pointColumnSize;
  final String pointBorderRadius;
  final String? pointBackgroundUrl;
  final String? backgroundUrl;
  final String? title;
  final String? subtitle;

  StyleDTO({
    required this.id,
    required this.pointColor,
    required this.pointShowNumbers,
    required this.pointBorderSize,
    required this.pointColumnSize,
    required this.pointBorderRadius,
    this.pointBackgroundUrl,
    this.backgroundUrl,
    this.title,
    this.subtitle,
  });

  factory StyleDTO.fromJson(Map<String, dynamic> json) =>
      _$StyleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StyleDTOToJson(this);
}
