import 'dart:convert';

import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';
import 'package:http/http.dart' as http;

import 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final String _baseUrl;

  AuthDataSourceImpl(this._baseUrl); // Inject the base URL during construction

  @override
  Future<void> requestForgotPassword({required String email}) async {
    try {
      final url = Uri.parse('$_baseUrl/forgot-password');
      final response = await http.post(url, body: {'email': email});
      if (response.statusCode == 200) {
        print('Forgot password request sent successfully.');
      } else {
        throw Exception(
            'Failed to request forgot password: ${response.statusCode}');
      }
    } on Exception catch (error) {
      print('Error requesting forgot password: ${error.toString()}');
    }
  }

  @override
  Future<UserDTO> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final url = Uri.parse('$_baseUrl/user/signin');
      final response =
          await http.post(url, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return UserDTO.fromJSON(data);
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } on Exception catch (error) {
      print('Error signing in: ${error.toString()}');
      throw error;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final url = Uri.parse('$_baseUrl/logout');
      final response = await http.post(url);
      if (response.statusCode == 200) {
        print('Logged out successfully.');
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } on Exception catch (error) {
      print('Error signing out: ${error.toString()}');
    }
  }

  @override
  Future<void> signUpWithEmail(CreateUserDTO user) async {
    try {
      final url = Uri.parse('$_baseUrl/user/signup');
      final response = await http.post(url, body: user.toJSON());
      if (response.statusCode == 201) {
        print('Signed up successfully.');
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'],
          message: data['message'],
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (error) {
      print('Error signing up: ${error.toString()}');
      throw error;
    }
  }
}
