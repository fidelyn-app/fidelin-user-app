import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class SignUpWithEmailUseCase {
  Future<Either<Failure, Unit>> call(CreateUserDTO user);
}

class SignUpWithEmailUseCaseImpl implements SignUpWithEmailUseCase {
  final AuthRepository _repository;

  SignUpWithEmailUseCaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call(CreateUserDTO user) {
    return _repository.signUpWithEmail(user);
  }
}
