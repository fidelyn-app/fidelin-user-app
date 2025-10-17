import 'dart:convert';

import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/core/services/http_client.dart';
import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/mapper/user_mapper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final String _baseUrl;

  final http.Client _httpClient = Modular.get<HttpClient>();
  final Logger _logger = Modular.get<Logger>();

  AuthDataSourceImpl({required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<void> requestForgotPassword({required String email}) async {
    try {
      final url = Uri.parse('$_baseUrl/user/forgot-password');
      final response = await _httpClient.post(url, body: {'email': email});

      Map<String, dynamic>? data;

      if (response.body.isNotEmpty) {
        try {
          data = jsonDecode(response.body) as Map<String, dynamic>;
        } catch (e) {
          _logger.i('Aviso: resposta não é JSON válido: $e');
        }
      }

      if (response.statusCode == 200) {
        _logger.d('Forgot password request sent successfully.');
        return;
      }

      throw Failure(
        error: data?['error'] ?? '',
        message: data?['message'] ?? 'Erro desconhecido',
        statusCode: response.statusCode,
      );
    } on Failure {
      rethrow;
    } catch (e, s) {
      _logger.e('Erro inesperado em requestForgotPassword: $e', stackTrace: s);
      throw Failure(
        message: 'Falha ao enviar solicitação de esqueci minha senha',
        statusCode: 500,
      );
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
    } on Failure {
      rethrow;
    } catch (e, s) {
      _logger.e('Erro inesperado em signInWithEmail: $e', stackTrace: s);
      throw Failure(
        message: 'Ocorreu um erro inesperado. Tente novamente.',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final url = Uri.parse('$_baseUrl/logout');
      final response = await _httpClient.post(url);
      if (response.statusCode == 200) {
      } else {
        throw Failure(
          message: 'Falha ao fazer logout',
          statusCode: response.statusCode,
        );
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      _logger.e('Erro inesperado em signOut: $e', stackTrace: s);
      throw Failure(message: 'Falha ao fazer logout', statusCode: 500);
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
    } on Failure {
      rethrow;
    } catch (e, s) {
      _logger.e('Erro inesperado em signUpWithEmail: $e', stackTrace: s);
      throw Failure(message: 'Falha ao realizar o cadastro', statusCode: 500);
    }
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/user/update-password');
      final response = await _httpClient.post(
        url,
        body: {'email': email, 'code': code, 'password': password},
      );
      if (response.statusCode == 201) {
        return;
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'],
          message: data['message'].toString(),
          statusCode: response.statusCode,
        );
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      _logger.e('Erro inesperado em updatePassword: $e', stackTrace: s);
      throw Failure(message: 'Falha ao atualizar a senha', statusCode: 500);
    }
  }
}
