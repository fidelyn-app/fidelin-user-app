import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';

abstract class CardsRepository {
  Future<Either<Exception, List<UserCard>>> fetchCards();

  Future<Either<Exception, Unit>> addCard({required String cardId});

  Future<Either<Exception, Unit>> addPoint({
    required String cardId,
    required String pointId,
  });

  Future<Either<Exception, Unit>> deleteCard({required String cardId});

  Future<Either<Failure, Unit>> deleteAccount({required String userId});
}
