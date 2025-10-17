import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/repositories/cards_repository.dart';

abstract class AddPointUseCase {
  Future<Either<Exception, Unit>> call(
      {required String cardId, required String pointId});
}

class AddPointUseCaseImpl implements AddPointUseCase {
  final CardsRepository _repository;

  AddPointUseCaseImpl({required CardsRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, Unit>> call(
      {required String cardId, required String pointId}) {
    return _repository.addPoint(cardId: cardId, pointId: pointId);
  }
}
