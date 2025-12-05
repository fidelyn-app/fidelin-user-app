import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/cards_repository.dart';

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
