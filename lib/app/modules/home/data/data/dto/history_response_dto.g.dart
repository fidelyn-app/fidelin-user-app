// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponseDTO _$HistoryResponseDTOFromJson(Map<String, dynamic> json) =>
    HistoryResponseDTO(
      items: HistoryResponseDTO._itemsFromJson(json['items'] as List),
      meta: HistoryResponseDTO._metaFromJson(
        json['meta'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$HistoryResponseDTOToJson(HistoryResponseDTO instance) =>
    <String, dynamic>{
      'items': HistoryResponseDTO._itemsToJson(instance.items),
      'meta': HistoryResponseDTO._metaToJson(instance.meta),
    };

HistoryMetaDTO _$HistoryMetaDTOFromJson(Map<String, dynamic> json) =>
    HistoryMetaDTO(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryMetaDTOToJson(HistoryMetaDTO instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'perPage': instance.perPage,
      'totalPages': instance.totalPages,
    };
