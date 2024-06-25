import 'package:json_annotation/json_annotation.dart';

part 'point_dto.g.dart';

@JsonSerializable()
class PointDTO {
  final String id;
  final bool used;
  final DateTime createdAt;
  final DateTime updatedAt;

  PointDTO({
    required this.id,
    required this.used,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PointDTO.fromJson(Map<String, dynamic> json) =>
      _$PointDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PointDTOToJson(this);
}
