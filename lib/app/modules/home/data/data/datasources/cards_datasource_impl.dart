import 'dart:async';
import 'dart:convert';

import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/dto/user_card_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'cards_datasource.dart';

class CardsDataSourceImpl implements CardsDataSource {
  final String _baseUrl;

  CardsDataSourceImpl({required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<List<UserCardDTO>> fetchCards() async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards');
      final response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final List<UserCardDTO> cards = [];
        for (var item in data) {
          final card = UserCardDTO.fromJson(item as Map<String, dynamic>);
          cards.add(card);
        }

        return cards;
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (error) {
      rethrow;
    } on TimeoutException catch (_) {
      throw Failure(
        message: 'O servidor demorou para responder.',
        error: 'Timeout',
        statusCode: 408,
      );
    }
  }

  @override
  Future<void> addCard({required String cardId}) async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards/$cardId');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addPoint({
    required String cardId,
    required String pointId,
  }) async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards/$cardId/point/$pointId');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCard({required String cardId}) async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards/$cardId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount({required String userId}) async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/$userId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (_) {
      rethrow;
    }
  }
}
