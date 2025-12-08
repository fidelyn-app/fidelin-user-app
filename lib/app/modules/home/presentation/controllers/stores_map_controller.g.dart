// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_map_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoresMapController on _StoresMapControllerBase, Store {
  late final _$storesAtom = Atom(
    name: '_StoresMapControllerBase.stores',
    context: context,
  );

  @override
  ObservableList<NearbyStore> get stores {
    _$storesAtom.reportRead();
    return super.stores;
  }

  @override
  set stores(ObservableList<NearbyStore> value) {
    _$storesAtom.reportWrite(value, super.stores, () {
      super.stores = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_StoresMapControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_StoresMapControllerBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchNearbyStoresAsyncAction = AsyncAction(
    '_StoresMapControllerBase.fetchNearbyStores',
    context: context,
  );

  @override
  Future<void> fetchNearbyStores({
    required double latitude,
    required double longitude,
  }) {
    return _$fetchNearbyStoresAsyncAction.run(
      () => super.fetchNearbyStores(latitude: latitude, longitude: longitude),
    );
  }

  @override
  String toString() {
    return '''
stores: ${stores},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
