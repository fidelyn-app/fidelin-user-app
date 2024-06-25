import 'package:json_annotation/json_annotation.dart';

part 'store_dto.g.dart';

@JsonSerializable()
class StoreDTO {
  final String id;
  final String businessName;
  final String? legalName;
  final String taxId;
  final String email;
  final String password;
  final bool active;
  final String? avatarUrl;
  final String? phone;
  final String stripeId;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime updatedAt;

  StoreDTO({
    required this.id,
    required this.businessName,
    this.legalName,
    required this.taxId,
    required this.email,
    required this.password,
    this.avatarUrl,
    this.phone,
    required this.active,
    required this.stripeId,
    required this.createdAt,
    required this.updatedAt,
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
