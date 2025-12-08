import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/nearby_store_entity.dart';

abstract class NearbyStoresRepository {
  Future<Either<Exception, List<NearbyStore>>> fetchNearbyStores({
    required double latitude,
    required double longitude,
  });
}
