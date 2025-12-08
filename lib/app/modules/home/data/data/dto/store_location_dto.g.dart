// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreLocationDTO _$StoreLocationDTOFromJson(Map<String, dynamic> json) =>
    StoreLocationDTO(
      id: json['id'] as String,
      postalCode: json['postalCode'] as String,
      street: json['street'] as String,
      complement: json['complement'] as String,
      unit: json['unit'] as String?,
      district: json['district'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      stateName: json['stateName'] as String,
      region: json['region'] as String,
      ddd: json['ddd'] as String,
      coordinates: StoreLocationDTO._coordinatesFromJson(
        json['coordinates'] as Map<String, dynamic>?,
      ),
    );

Map<String, dynamic> _$StoreLocationDTOToJson(StoreLocationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postalCode': instance.postalCode,
      'street': instance.street,
      'complement': instance.complement,
      'unit': instance.unit,
      'district': instance.district,
      'city': instance.city,
      'state': instance.state,
      'stateName': instance.stateName,
      'region': instance.region,
      'ddd': instance.ddd,
      'coordinates': StoreLocationDTO._coordinatesToJson(instance.coordinates),
    };
