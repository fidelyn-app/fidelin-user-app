import 'package:json_annotation/json_annotation.dart';

import 'card_dto.dart'; // For TimeToExpireDTO

part 'reward_dto.g.dart';

@JsonSerializable()
class RewardDTO {
  final String id;
  final String title;
  final String? description;
  final int pointsRequired;
  final String expirationModel;
  final TimeToExpireDTO? timeToExpire;
  final DateTime? dateToExpire;
  final String storeId;
  //final bool active;

  RewardDTO({
    required this.id,
    required this.title,
    this.description,
    required this.pointsRequired,
    required this.expirationModel,
    this.timeToExpire,
    this.dateToExpire,
    required this.storeId,
    //required this.active,
  });

  factory RewardDTO.fromJson(Map<String, dynamic> json) =>
      _$RewardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RewardDTOToJson(this);
}
