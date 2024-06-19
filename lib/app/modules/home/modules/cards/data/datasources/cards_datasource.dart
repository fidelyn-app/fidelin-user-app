import 'package:fidelin_user_app/app/modules/home/modules/cards/data/dto/user_card_dto.dart';

abstract class CardsDataSource {
  Future<List<UserCardDTO>> fetchCards();
}
