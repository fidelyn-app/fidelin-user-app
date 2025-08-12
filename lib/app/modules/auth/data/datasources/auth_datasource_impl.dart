import 'dart:convert';

import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/core/services/http_client.dart';
import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/mapper/user_mapper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final String _baseUrl;

  final http.Client _httpClient = Modular.get<HttpClient>();

  AuthDataSourceImpl({required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<void> requestForgotPassword({required String email}) async {
    try {
      final url = Uri.parse('$_baseUrl/user/forgot-password');
      final response = await _httpClient.post(url, body: {'email': email});
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print('Forgot password request sent successfully.');
      } else {
        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw Exception('Failed to send forgot password request: $e');
    }
  }

  @override
  Future<UserDTO> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/user/signin');
      final response = await _httpClient.post(
        url,
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final user = UserDTO.fromMap(data['user']);
        Modular.get<AppStore>().setToken(data['token']);
        Modular.get<AppStore>().setUser(UserMapper.mapDTOtoEntity(user));
        return user;
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw Failure(message: '', statusCode: 500);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final url = Uri.parse('$_baseUrl/logout');
      final response = await _httpClient.post(url);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<void> signUpWithEmail(CreateUserDTO user) async {
    try {
      final url = Uri.parse('$_baseUrl/user/signup');
      final response = await _httpClient.post(url, body: user.toJSON());
      if (response.statusCode == 201) {
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'],
          message: data['message'],
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/user/signup');
      final response = await _httpClient.post(url, body: '');
      if (response.statusCode == 201) {
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'],
          message: data['message'],
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
