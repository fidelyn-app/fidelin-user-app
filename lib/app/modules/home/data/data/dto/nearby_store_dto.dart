import 'package:json_annotation/json_annotation.dart';

import 'store_contact_dto.dart';
import 'store_location_dto.dart';

part 'nearby_store_dto.g.dart';

@JsonSerializable()
class NearbyStoreDTO {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final bool active;
  final String? avatarUrl;
  final String stripeId;
  final StoreLocationDTO location;
  final StoreContactDTO contact;
  final double distance;

  NearbyStoreDTO({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    required this.active,
    this.avatarUrl,
    required this.stripeId,
    required this.location,
    required this.contact,
    required this.distance,
  });

  factory NearbyStoreDTO.fromJson(Map<String, dynamic> json) =>
      _$NearbyStoreDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoreDTOToJson(this);
}

