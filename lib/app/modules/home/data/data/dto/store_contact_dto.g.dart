// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_contact_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreContactDTO _$StoreContactDTOFromJson(Map<String, dynamic> json) =>
    StoreContactDTO(
      id: json['id'] as String,
      primaryPhone: json['primaryPhone'] as String?,
      secondaryPhone: json['secondaryPhone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      email: json['email'] as String,
      website: json['website'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      telegram: json['telegram'] as String?,
      tiktok: json['tiktok'] as String?,
      youtube: json['youtube'] as String?,
    );

Map<String, dynamic> _$StoreContactDTOToJson(StoreContactDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'primaryPhone': instance.primaryPhone,
      'secondaryPhone': instance.secondaryPhone,
      'whatsapp': instance.whatsapp,
      'email': instance.email,
      'website': instance.website,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'telegram': instance.telegram,
      'tiktok': instance.tiktok,
      'youtube': instance.youtube,
    };
