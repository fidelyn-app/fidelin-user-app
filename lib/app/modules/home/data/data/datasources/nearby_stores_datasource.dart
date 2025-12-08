import 'package:fidelyn_user_app/app/modules/home/data/data/dto/nearby_store_dto.dart';

abstract class NearbyStoresDataSource {
  Future<List<NearbyStoreDTO>> fetchNearbyStores({
    required double latitude,
    required double longitude,
  });
}
