import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class UpdatePasswordUseCase {
  Future<Either<Failure, Unit>> call(
      {required String email, required String code, required String password});
}

class UpdatePasswordUseCaseImpl implements UpdatePasswordUseCase {
  final AuthRepository _repository;

  UpdatePasswordUseCaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call(
      {required String email, required String code, required String password}) {
    return _repository.updatePassword(
        email: email, code: code, password: password);
  }
}
