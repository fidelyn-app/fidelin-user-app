import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/repositories/cards_repository.dart';

abstract class FetchCardsUseCase {
  Future<Either<Exception, List<UserCard>>> call();
}

class FetchCardsUseCaseImpl implements FetchCardsUseCase {
  final CardsRepository _repository;

  FetchCardsUseCaseImpl({required CardsRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, List<UserCard>>> call() {
    return _repository.fetchCards();
  }
}
