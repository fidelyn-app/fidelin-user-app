// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDTO _$StoreDTOFromJson(Map<String, dynamic> json) => StoreDTO(
  id: json['id'] as String,
  businessName: json['businessName'] as String,
  legalName: json['legalName'] as String?,
  taxId: json['taxId'] as String,
  email: json['email'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  phone: json['phone'] as String?,
  active: json['active'] as bool,
  stripeId: json['stripeId'] as String,
  location: StoreDTO._locationFromJson(
    json['location'] as Map<String, dynamic>?,
  ),
  contact: StoreDTO._contactFromJson(json['contact'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreDTOToJson(StoreDTO instance) => <String, dynamic>{
  'id': instance.id,
  'businessName': instance.businessName,
  'legalName': instance.legalName,
  'taxId': instance.taxId,
  'email': instance.email,
  'active': instance.active,
  'avatarUrl': instance.avatarUrl,
  'phone': instance.phone,
  'stripeId': instance.stripeId,
  'location': StoreDTO._locationToJson(instance.location),
  'contact': StoreDTO._contactToJson(instance.contact),
};
