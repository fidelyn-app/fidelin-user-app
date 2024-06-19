import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/datasources/cards_datasource.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/mapper/user_card_mapper.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/repositories/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  final CardsDataSource _dataSource;

  CardsRepositoryImpl({required CardsDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Exception, List<UserCard>>> fetchCards() async {
    try {
      final result = await _dataSource.fetchCards();
      return right(
          result.map((item) => UserCardMapper.toEntity(item)).toList());
    } on Exception {
      return left(Exception("Erro Inesperado"));
    }
  }
}
