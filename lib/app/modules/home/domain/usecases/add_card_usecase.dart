import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/cards_repository.dart';

abstract class AddCardUseCase {
  Future<Either<Exception, Unit>> call({required String cardId});
}

class AddCardUseCaseImpl implements AddCardUseCase {
  final CardsRepository _repository;

  AddCardUseCaseImpl({required CardsRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, Unit>> call({required String cardId}) {
    return _repository.addCard(cardId: cardId);
  }
}
