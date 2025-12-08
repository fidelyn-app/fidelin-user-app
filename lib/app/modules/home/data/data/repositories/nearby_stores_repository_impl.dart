import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/core/errors/Failure.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/datasources/nearby_stores_datasource.dart';
import 'package:fidelyn_user_app/app/modules/home/data/data/mapper/nearby_store_mapper.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/nearby_store_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/nearby_stores_repository.dart';

class NearbyStoresRepositoryImpl implements NearbyStoresRepository {
  final NearbyStoresDataSource _dataSource;

  NearbyStoresRepositoryImpl({required NearbyStoresDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Exception, List<NearbyStore>>> fetchNearbyStores({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final result = await _dataSource.fetchNearbyStores(
        latitude: latitude,
        longitude: longitude,
      );
      return right(
        result.map((item) => NearbyStoreMapper.toEntity(item)).toList(),
      );
    } on Failure catch (e) {
      return left(
        Failure(
          message: e.message,
          statusCode: e.statusCode,
          error: e.error,
        ),
      );
    } on Exception {
      return left(
        Failure(
          message: "Erro inesperado",
          statusCode: 500,
          error: null,
        ),
      );
    }
  }
}
