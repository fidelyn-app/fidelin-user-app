import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/data/datasources/auth_datasource.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/mapper/user_mapper.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final result =
          await _dataSource.signInWithEmail(email: email, password: password);
      UserEntity user = UserMapper.mapDTOtoEntity(result);
      return right(user);
    } on Failure catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpWithEmail(CreateUserDTO user) async {
    try {
      await _dataSource.signUpWithEmail(user);
      return right(unit);
    } on Failure catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({required String email}) async {
    try {
      await _dataSource.requestForgotPassword(email: email);
      return right(unit);
    } on Failure catch (error) {
      return left(error);
    } on Exception catch (_) {
      return left(
          const Failure(message: 'Unhandled exception!', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(
      {required String email,
      required String code,
      required String password}) async {
    try {
      await _dataSource.updatePassword(
          email: email, code: code, password: password);
      return right(unit);
    } on Failure catch (error) {
      return left(error);
    }
  }
}
