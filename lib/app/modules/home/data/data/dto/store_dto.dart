import 'package:fidelyn_user_app/app/modules/home/data/data/dto/store_contact_dto.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/dto/store_location_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_dto.g.dart';

@JsonSerializable()
class StoreDTO {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final bool active;
  final String? avatarUrl;
  final String? phone;
  final String stripeId;

  @JsonKey(fromJson: _locationFromJson, toJson: _locationToJson)
  final StoreLocationDTO? location;
  @JsonKey(fromJson: _contactFromJson, toJson: _contactToJson)
  final StoreContactDTO contact;

  StoreDTO({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    this.avatarUrl,
    this.phone,
    required this.active,
    required this.stripeId,
    this.location,
    required this.contact,
  });

  factory StoreDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDTOToJson(this);

  static StoreLocationDTO? _locationFromJson(Map<String, dynamic>? json) =>
      json != null ? StoreLocationDTO.fromJson(json) : null;
  static Map<String, dynamic>? _locationToJson(StoreLocationDTO? location) =>
      location?.toJson();

  static StoreContactDTO _contactFromJson(Map<String, dynamic> json) =>
      StoreContactDTO.fromJson(json);
  static Map<String, dynamic> _contactToJson(StoreContactDTO contact) =>
      contact.toJson();
}
