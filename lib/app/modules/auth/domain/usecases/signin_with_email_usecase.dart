import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class SignInWithEmailUseCase {
  Future<Either<Failure, UserEntity>> call(
      {required String email, required String password});
}

class SignInWithEmailUseCaseImpl implements SignInWithEmailUseCase {
  final AuthRepository _repository;

  SignInWithEmailUseCaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, UserEntity>> call(
      {required String email, required String password}) {
    return _repository.signInWithEmail(email: email, password: password);
  }
}
