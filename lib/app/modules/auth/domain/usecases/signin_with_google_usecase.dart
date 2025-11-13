import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class SignInWithGoogleUseCase {
  Future<Either<Failure, UserEntity>> call({required String firebaseToken});
}

class SignInWithGoogleUseCaseImpl implements SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCaseImpl({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, UserEntity>> call({
    required String firebaseToken,
  }) async {
    return await _repository.signInWithGoogle(firebaseToken: firebaseToken);
  }
}
