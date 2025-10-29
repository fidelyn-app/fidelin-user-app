import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/datasources/cards_datasource.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/mapper/user_card_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/domain/repositories/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  final CardsDataSource _dataSource;

  CardsRepositoryImpl({required CardsDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Exception, List<UserCard>>> fetchCards() async {
    try {
      final result = await _dataSource.fetchCards();
      return right(
        result.map((item) => UserCardMapper.toEntity(item)).toList(),
      );
    } on Failure catch (e) {
      return left(
        Failure(message: e.message, statusCode: e.statusCode, error: e.error),
      );
    } on Exception {
      return left(
        Failure(message: "Erro inesperado", statusCode: 500, error: null),
      );
    }
  }

  @override
  Future<Either<Exception, Unit>> addCard({required String cardId}) async {
    try {
      await _dataSource.addCard(cardId: cardId);
      return right(unit);
    } on Failure catch (e) {
      return left(
        Failure(message: e.message, statusCode: e.statusCode, error: e.error),
      );
    } on Exception {
      return left(Exception("Erro Inesperado"));
    }
  }

  @override
  Future<Either<Exception, Unit>> addPoint({
    required String cardId,
    required String pointId,
  }) async {
    try {
      await _dataSource.addPoint(cardId: cardId, pointId: pointId);
      return right(unit);
    } on Failure catch (e) {
      return left(
        Failure(message: e.message, statusCode: e.statusCode, error: e.error),
      );
    } on Exception {
      return left(Exception("Erro Inesperado"));
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteCard({required String cardId}) async {
    try {
      await _dataSource.deleteCard(cardId: cardId);
      return right(unit);
    } on Failure catch (e) {
      return left(
        Failure(message: e.message, statusCode: e.statusCode, error: e.error),
      );
    } on Exception {
      return left(Exception("Erro Inesperado"));
    }
  }
}
