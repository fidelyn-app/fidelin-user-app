import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(
      {required String email, required String password});

  Future<Either<Failure, Unit>> signUpWithEmail(CreateUserDTO user);

  Future<Either<Failure, Unit>> forgotPassword({required String email});

  Future<Either<Failure, Unit>> updatePassword(
      {required String email, required String code, required String password});
}
