// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_coordinates_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationCoordinatesDTO _$LocationCoordinatesDTOFromJson(
  Map<String, dynamic> json,
) => LocationCoordinatesDTO(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LocationCoordinatesDTOToJson(
  LocationCoordinatesDTO instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
