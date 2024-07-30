import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';

abstract class AuthDataSource {
  Future<UserDTO> signInWithEmail(
      {required String email, required String password});

  Future<void> signUpWithEmail(CreateUserDTO user);

  Future<void> signOut();

  Future<void> requestForgotPassword({required String email});

  Future<void> updatePassword(
      {required String email, required String code, required String password});
}
