import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> signInWithEmail(
      {required String email, required String password});

  Future<Either<Exception, Unit>> signUpWithEmail(CreateUserDTO user);

  Future<Either<Exception, Unit>> forgotPassword({required String email});
}
