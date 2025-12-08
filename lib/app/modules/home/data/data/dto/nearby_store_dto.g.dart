// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_store_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyStoreDTO _$NearbyStoreDTOFromJson(
  Map<String, dynamic> json,
) => NearbyStoreDTO(
  id: json['id'] as String,
  businessName: json['businessName'] as String,
  legalName: json['legalName'] as String?,
  taxId: json['taxId'] as String,
  email: json['email'] as String,
  active: json['active'] as bool,
  avatarUrl: json['avatarUrl'] as String?,
  stripeId: json['stripeId'] as String,
  location: StoreLocationDTO.fromJson(json['location'] as Map<String, dynamic>),
  contact: StoreContactDTO.fromJson(json['contact'] as Map<String, dynamic>),
  distance: (json['distance'] as num).toDouble(),
);

Map<String, dynamic> _$NearbyStoreDTOToJson(NearbyStoreDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'legalName': instance.legalName,
      'taxId': instance.taxId,
      'email': instance.email,
      'active': instance.active,
      'avatarUrl': instance.avatarUrl,
      'stripeId': instance.stripeId,
      'location': instance.location,
      'contact': instance.contact,
      'distance': instance.distance,
    };
