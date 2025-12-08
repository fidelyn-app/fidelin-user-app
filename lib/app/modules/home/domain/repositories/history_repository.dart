import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/history_response_entity.dart';

abstract class HistoryRepository {
  Future<Either<Exception, HistoryResponse>> fetchHistory({
    required int page,
    required int perPage,
  });
}
