import 'package:json_annotation/json_annotation.dart';

import 'user_card_dto.dart';

part 'history_response_dto.g.dart';

@JsonSerializable()
class HistoryResponseDTO {
  @JsonKey(fromJson: _itemsFromJson, toJson: _itemsToJson)
  final List<UserCardDTO> items;

  @JsonKey(fromJson: _metaFromJson, toJson: _metaToJson)
  final HistoryMetaDTO meta;

  HistoryResponseDTO({required this.items, required this.meta});

  static List<UserCardDTO> _itemsFromJson(List<dynamic> json) =>
      json
          .map((item) => UserCardDTO.fromJson(item as Map<String, dynamic>))
          .toList();
  static List<Map<String, dynamic>> _itemsToJson(List<UserCardDTO> items) =>
      items.map((item) => item.toJson()).toList();

  static HistoryMetaDTO _metaFromJson(Map<String, dynamic> json) =>
      HistoryMetaDTO.fromJson(json);
  static Map<String, dynamic> _metaToJson(HistoryMetaDTO meta) => meta.toJson();

  factory HistoryResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseDTOToJson(this);
}

@JsonSerializable()
class HistoryMetaDTO {
  final int total;
  final int page;
  final int perPage;
  final int totalPages;

  HistoryMetaDTO({
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
  });

  factory HistoryMetaDTO.fromJson(Map<String, dynamic> json) =>
      _$HistoryMetaDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMetaDTOToJson(this);
}
