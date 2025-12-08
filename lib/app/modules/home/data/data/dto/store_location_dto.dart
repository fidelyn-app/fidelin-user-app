import 'package:json_annotation/json_annotation.dart';

import 'location_coordinates_dto.dart';

part 'store_location_dto.g.dart';

@JsonSerializable()
class StoreLocationDTO {
  final String id;
  final String postalCode;
  final String street;
  final String complement;
  final String? unit;
  final String district;
  final String city;
  final String state;
  final String stateName;
  final String region;
  final String ddd;

  @JsonKey(fromJson: _coordinatesFromJson, toJson: _coordinatesToJson)
  final LocationCoordinatesDTO? coordinates;

  StoreLocationDTO({
    required this.id,
    required this.postalCode,
    required this.street,
    required this.complement,
    this.unit,
    required this.district,
    required this.city,
    required this.state,
    required this.stateName,
    required this.region,
    required this.ddd,
    this.coordinates,
  });

  factory StoreLocationDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreLocationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StoreLocationDTOToJson(this);

  static LocationCoordinatesDTO? _coordinatesFromJson(
    Map<String, dynamic>? json,
  ) => json != null ? LocationCoordinatesDTO.fromJson(json) : null;
  static Map<String, dynamic>? _coordinatesToJson(
    LocationCoordinatesDTO? coordinates,
  ) => coordinates?.toJson();
}
