import 'dart:async';
import 'dart:convert';

import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/datasources/history_datasource.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/dto/history_response_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class HistoryDataSourceImpl implements HistoryDataSource {
  final String _baseUrl;

  HistoryDataSourceImpl({required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<HistoryResponseDTO> fetchHistory({
    required int page,
    required int perPage,
  }) async {
    try {
      String token = Modular.get<AppStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards/history').replace(
        queryParameters: {
          'page': page.toString(),
          'perPage': perPage.toString(),
        },
      );

      final response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return HistoryResponseDTO.fromJson(data);
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
}
