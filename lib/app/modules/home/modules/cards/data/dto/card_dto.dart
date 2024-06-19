import 'package:json_annotation/json_annotation.dart';

import 'store_dto.dart';

part 'card_dto.g.dart';

@JsonSerializable()
class CardDTO {
  final String id;
  final String? backgroundUrl; // Allow null for optional fields
  final int maxPoints;
  final String color;
  final String description;
  final bool active;
  final String storeId;
  @JsonKey(fromJson: _timeToExpireFromJson, toJson: _timeToExpireToJson)
  final TimeToExpireDTO timeToExpire;
  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(fromJson: _storeFromJson, toJson: _storeToJson)
  final StoreDTO store;

  CardDTO({
    required this.id,
    this.backgroundUrl,
    required this.maxPoints,
    required this.color,
    required this.description,
    required this.active,
    required this.storeId,
    required this.timeToExpire,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
  });

  // Custom deserialization/serialization for nested objects
  static TimeToExpireDTO _timeToExpireFromJson(Map<String, dynamic> json) =>
      TimeToExpireDTO.fromJson(json['timeToExpire']);
  static Map<String, dynamic> _timeToExpireToJson(
          TimeToExpireDTO timeToExpire) =>
      timeToExpire.toJson();

  static StoreDTO _storeFromJson(Map<String, dynamic> json) =>
      StoreDTO.fromJson(json['store']);
  static Map<String, dynamic> _storeToJson(StoreDTO store) => store.toJson();

  factory CardDTO.fromJson(Map<String, dynamic> json) =>
      _$CardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CardDTOToJson(this);
}

@JsonSerializable()
class TimeToExpireDTO {
  final int months;

  TimeToExpireDTO({
    required this.months,
  });

  factory TimeToExpireDTO.fromJson(Map<String, dynamic> json) =>
      _$TimeToExpireDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToExpireDTOToJson(this);
}
