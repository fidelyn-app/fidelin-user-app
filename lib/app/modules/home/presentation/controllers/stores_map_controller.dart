import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/nearby_store_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/usecases/fetch_nearby_stores_usecase.dart';
import 'package:mobx/mobx.dart';

part 'stores_map_controller.g.dart';

class StoresMapController = _StoresMapControllerBase with _$StoresMapController;

abstract class _StoresMapControllerBase with Store {
  late FetchNearbyStoresUseCase _fetchNearbyStoresUseCase;

  _StoresMapControllerBase({
    required FetchNearbyStoresUseCase fetchNearbyStoresUseCase,
  }) {
    _fetchNearbyStoresUseCase = fetchNearbyStoresUseCase;
  }

  @observable
  ObservableList<NearbyStore> stores = ObservableList<NearbyStore>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> fetchNearbyStores({
    required double latitude,
    required double longitude,
  }) async {
    isLoading = true;
    errorMessage = null;

    final Either<Exception, List<NearbyStore>> response =
        await _fetchNearbyStoresUseCase.call(
      latitude: latitude,
      longitude: longitude,
    );

    response.fold(
      (Exception e) {
        errorMessage = e.toString();
        stores.clear();
      },
      (List<NearbyStore> listOfStores) {
        stores.clear();
        stores.addAll(listOfStores);
      },
    );

    isLoading = false;
  }
}
