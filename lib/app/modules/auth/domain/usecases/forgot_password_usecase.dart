import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ForgotPasswordUseCase {
  Future<Either<Failure, Unit>> call({required String email});
}

class ForgotPasswordUseCaseImpl implements ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCaseImpl({required AuthRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, Unit>> call({required String email}) {
    return _repository.forgotPassword(email: email);
  }
}
