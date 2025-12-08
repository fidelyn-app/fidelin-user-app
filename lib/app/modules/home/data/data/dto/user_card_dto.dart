import 'package:json_annotation/json_annotation.dart';

import 'card_dto.dart';
import 'point_dto.dart';
import 'reward_dto.dart';

part 'user_card_dto.g.dart';

@JsonSerializable()
class UserCardDTO {
  final String id;
  final DateTime? expiration;
  final int pointsCount;
  final String userId;
  final String shortCode;
  final String status;

  @JsonKey(fromJson: _cardFromJson, toJson: _cardToJson)
  final CardDTO card;

  @JsonKey(fromJson: _pointsFromJson, toJson: _pointsToJson)
  final List<PointDTO> points;

  @JsonKey(fromJson: _rewardFromJson, toJson: _rewardToJson)
  final RewardDTO reward;

  UserCardDTO({
    required this.id,
    required this.expiration,
    required this.pointsCount,
    required this.userId,
    required this.card,
    required this.points,
    required this.shortCode,
    required this.reward,
    required this.status,
  });

  static CardDTO _cardFromJson(Map<String, dynamic> json) =>
      CardDTO.fromJson(json);
  static Map<String, dynamic> _cardToJson(CardDTO card) => card.toJson();

  static List<PointDTO> _pointsFromJson(List<dynamic> json) =>
      json.map((p) => PointDTO.fromJson(p)).toList();
  static List<Map<String, dynamic>> _pointsToJson(List<PointDTO> points) =>
      points.map((p) => p.toJson()).toList();

  static RewardDTO _rewardFromJson(Map<String, dynamic> json) =>
      RewardDTO.fromJson(json);
  static Map<String, dynamic> _rewardToJson(RewardDTO reward) =>
      reward.toJson();

  factory UserCardDTO.fromJson(Map<String, dynamic> json) =>
      _$UserCardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserCardDTOToJson(this);
}
