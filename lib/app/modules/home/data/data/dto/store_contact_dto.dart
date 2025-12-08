import 'package:json_annotation/json_annotation.dart';

part 'store_contact_dto.g.dart';

@JsonSerializable()
class StoreContactDTO {
  final String id;
  final String? primaryPhone;
  final String? secondaryPhone;
  final String? whatsapp;
  final String email;
  final String? website;
  final String? instagram;
  final String? facebook;
  final String? telegram;
  final String? tiktok;
  final String? youtube;

  StoreContactDTO({
    required this.id,
    this.primaryPhone,
    this.secondaryPhone,
    this.whatsapp,
    required this.email,
    this.website,
    this.instagram,
    this.facebook,
    this.telegram,
    this.tiktok,
    this.youtube,
  });

  factory StoreContactDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreContactDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StoreContactDTOToJson(this);
}
