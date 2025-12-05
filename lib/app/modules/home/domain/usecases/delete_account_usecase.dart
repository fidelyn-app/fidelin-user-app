import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/cards_repository.dart';

class DeleteAccountUseCase {
  final CardsRepository _repository;

  DeleteAccountUseCase(this._repository);

  Future<Either<Failure, Unit>> call(String userId) async {
    return await _repository.deleteAccount(userId: userId);
  }
}
