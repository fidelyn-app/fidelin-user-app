import 'package:json_annotation/json_annotation.dart';

part 'location_coordinates_dto.g.dart';

@JsonSerializable()
class LocationCoordinatesDTO {
  final double latitude;
  final double longitude;

  LocationCoordinatesDTO({required this.latitude, required this.longitude});

  factory LocationCoordinatesDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationCoordinatesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationCoordinatesDTOToJson(this);
}

