import 'dart:async';
import 'dart:convert';

import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/datasources/nearby_stores_datasource.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/dto/nearby_store_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class NearbyStoresDataSourceImpl implements NearbyStoresDataSource {
  final String _baseUrl;

  NearbyStoresDataSourceImpl({required String baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<List<NearbyStoreDTO>> fetchNearbyStores({
    required double latitude,
    required double longitude,
  }) async {
    try {
      String? token;
      try {
        token = Modular.get<AppStore>().getToken();
      } catch (e) {
        // Token não disponível, continuar sem autenticação
      }

      final url = Uri.parse(
        '$_baseUrl/store/nearby?latitude=$latitude&longitude=$longitude',
      );

      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final List<NearbyStoreDTO> stores = [];

        for (var item in data) {
          try {
            final nearbyStoreDTO = NearbyStoreDTO.fromJson(
              item as Map<String, dynamic>,
            );
            stores.add(nearbyStoreDTO);
          } catch (e) {
            // Ignorar itens com erro de conversão
            continue;
          }
        }

        return stores;
      } else {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        throw Failure(
          error: errorData['error'] ?? '',
          message: errorData['message'] ?? 'Erro ao buscar lojas próximas',
          statusCode: response.statusCode,
        );
      }
    } on Failure {
      rethrow;
    } on TimeoutException catch (_) {
      throw Failure(
        message: 'O servidor demorou para responder.',
        error: 'Timeout',
        statusCode: 408,
      );
    } catch (e) {
      throw Failure(
        message: 'Erro ao buscar lojas próximas: ${e.toString()}',
        error: 'UnknownError',
        statusCode: 500,
      );
    }
  }
}
