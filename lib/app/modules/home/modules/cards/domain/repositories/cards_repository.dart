import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';

abstract class CardsRepository {
  Future<Either<Exception, List<UserCard>>> fetchCards();
}
