import 'dart:convert';

import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/core/stores/user_store.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/dto/user_card_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'cards_datasource.dart';

class CardsDataSourceImpl implements CardsDataSource {
  final String _baseUrl;

  CardsDataSourceImpl(this._baseUrl);

  @override
  Future<List<UserCardDTO>> fetchCards() async {
    try {
      String token = Modular.get<UserStore>().getToken();

      final url = Uri.parse('$_baseUrl/user/cards');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        for (var item in data) {
          final card = UserCardDTO.fromJson(item as Map<String, dynamic>);
          print(card);
        }

        return [];
      } else {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        throw Failure(
          error: data['error'] ?? '',
          message: data['message'] ?? '',
          statusCode: response.statusCode,
        );
      }
    } on Failure catch (error) {
      throw error;
    }
  }
}
