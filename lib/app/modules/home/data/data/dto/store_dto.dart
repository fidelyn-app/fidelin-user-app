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
  });

  // Handle proper DateTime conversion during serialization/deserialization
  static DateTime _dateTimeFromJson(String timestamp) =>
      DateTime.parse(timestamp);
  static String _dateTimeToJson(DateTime dateTime) =>
      dateTime.toIso8601String();

  factory StoreDTO.fromJson(Map<String, dynamic> json) =>
      _$StoreDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDTOToJson(this);
}
