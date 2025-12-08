import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/history_response_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/history_repository.dart';

abstract class FetchHistoryUseCase {
  Future<Either<Exception, HistoryResponse>> call({
    required int page,
    required int perPage,
  });
}

class FetchHistoryUseCaseImpl implements FetchHistoryUseCase {
  final HistoryRepository _repository;

  FetchHistoryUseCaseImpl({required HistoryRepository repository})
    : _repository = repository;

  @override
  Future<Either<Exception, HistoryResponse>> call({
    required int page,
    required int perPage,
  }) {
    return _repository.fetchHistory(page: page, perPage: perPage);
  }
}
