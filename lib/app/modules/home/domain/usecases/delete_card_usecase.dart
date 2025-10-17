import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/repositories/cards_repository.dart';

class DeleteCardUseCase {
  final CardsRepository _repository;

  DeleteCardUseCase(this._repository);

  Future<Either<Exception, Unit>> call({required String cardId}) async {
    return await _repository.deleteCard(cardId: cardId);
  }
}
