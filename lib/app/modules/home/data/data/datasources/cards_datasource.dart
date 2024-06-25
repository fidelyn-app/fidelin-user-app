import 'package:fidelin_user_app/app/modules/home/data/data/dto/user_card_dto.dart';

abstract class CardsDataSource {
  Future<List<UserCardDTO>> fetchCards();

  Future<void> addCard({required String cardId});

  Future<void> addPoint({required String pointId});
}
