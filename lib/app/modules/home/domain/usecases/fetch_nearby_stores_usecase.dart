import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/nearby_store_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/repositories/nearby_stores_repository.dart';

abstract class FetchNearbyStoresUseCase {
  Future<Either<Exception, List<NearbyStore>>> call({
    required double latitude,
    required double longitude,
  });
}

class FetchNearbyStoresUseCaseImpl implements FetchNearbyStoresUseCase {
  final NearbyStoresRepository _repository;

  FetchNearbyStoresUseCaseImpl({required NearbyStoresRepository repository})
      : _repository = repository;

  @override
  Future<Either<Exception, List<NearbyStore>>> call({
    required double latitude,
    required double longitude,
  }) {
    return _repository.fetchNearbyStores(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
