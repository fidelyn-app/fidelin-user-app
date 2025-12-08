import 'package:fidelyn_user_app/app/modules/home/data/data/dto/history_response_dto.dart';

abstract class HistoryDataSource {
  Future<HistoryResponseDTO> fetchHistory({
    required int page,
    required int perPage,
  });
}
