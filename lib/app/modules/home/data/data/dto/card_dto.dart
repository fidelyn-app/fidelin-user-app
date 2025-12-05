import 'package:fidelyn_user_app/app/modules/home/data/data/dto/style_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'reward_dto.dart';
import 'store_dto.dart';

part 'card_dto.g.dart';

@JsonSerializable()
class CardDTO {
  final String id;
  final String? color;
  //final bool active;
  final String storeId;
  @JsonKey(fromJson: _timeToExpireFromJson, toJson: _timeToExpireToJson)
  final TimeToExpireDTO? timeToExpire;

  @JsonKey(fromJson: _storeFromJson, toJson: _storeToJson)
  final StoreDTO store;

  @JsonKey(fromJson: _styleFromJson, toJson: _styleToJson)
  final StyleDTO style;

  CardDTO({
    required this.id,
    this.color,
    //required this.active,
    required this.storeId,
    required this.timeToExpire,
    required this.store,
    required this.style,
    //required this.reward,
  });

  static TimeToExpireDTO? _timeToExpireFromJson(Map<String, dynamic>? json) =>
      json != null ? TimeToExpireDTO.fromJson(json) : null;
  static Map<String, dynamic>? _timeToExpireToJson(
    TimeToExpireDTO? timeToExpire,
  ) => timeToExpire?.toJson();

  static StoreDTO _storeFromJson(Map<String, dynamic> json) =>
      StoreDTO.fromJson(json);
  static Map<String, dynamic> _storeToJson(StoreDTO store) => store.toJson();

  static StyleDTO _styleFromJson(Map<String, dynamic> json) =>
      StyleDTO.fromJson(json);
  static Map<String, dynamic> _styleToJson(StyleDTO style) => style.toJson();

  factory CardDTO.fromJson(Map<String, dynamic> json) =>
      _$CardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CardDTOToJson(this);
}

@JsonSerializable()
class TimeToExpireDTO {
  final int? years;
  final int? months;
  final int? days;
  final int? hours;
  final int? minutes;
  final int? seconds;

  TimeToExpireDTO({
    this.years,
    this.months,
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  factory TimeToExpireDTO.fromJson(Map<String, dynamic> json) =>
      _$TimeToExpireDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToExpireDTOToJson(this);
}
