import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/datasources/history_datasource.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/mapper/user_card_mapper.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/history_response_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource _dataSource;

  HistoryRepositoryImpl({required HistoryDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Exception, HistoryResponse>> fetchHistory({
    required int page,
    required int perPage,
  }) async {
    try {
      final result = await _dataSource.fetchHistory(
        page: page,
        perPage: perPage,
      );
      return right(
        HistoryResponse(
          items:
              result.items
                  .map((item) => UserCardMapper.toEntity(item))
                  .toList(),
          meta: HistoryMeta(
            total: result.meta.total,
            page: result.meta.page,
            perPage: result.meta.perPage,
            totalPages: result.meta.totalPages,
          ),
        ),
      );
    } on Failure catch (e) {
      return left(
        Failure(message: e.message, statusCode: e.statusCode, error: e.error),
      );
    } on Exception {
      return left(
        Failure(message: "Erro inesperado", statusCode: 500, error: null),
      );
    }
  }
}
