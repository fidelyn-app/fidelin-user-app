import 'package:fidelin_user_app/app/core/services/shared_local_storage_service.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/mapper/user_mapper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../domain/entities/user_entity.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserEntity? user;
  @observable
  String? _token;

  @computed
  bool get isLogged => user != null;

  @action
  Future<void> setUser(UserEntity userEntity) async {
    user = userEntity;

    var userMapped = UserMapper.mapEntityToDTO(userEntity);

    Modular.get<SharedLocalStorageService>()
        .put('fidelin/user', userMapped.toJSON());
  }

  @action
  Future<void> removeUser() async {
    user = null;
    _token = null;
  }

  @action
  Future<bool> check() async {
    String? userJSON =
        await Modular.get<SharedLocalStorageService>().get('fidelin/user');
    String? tokenJSON =
        await Modular.get<SharedLocalStorageService>().get('fidelin/token');

    if (userJSON == null && tokenJSON == null) {
      return false;
    }

    UserDTO.fromJSON(userJSON!);

    user = UserMapper.mapDTOtoEntity(UserDTO.fromJSON(userJSON!));
    _token = tokenJSON;

    return true;
  }

  @action
  void setToken(String newToken) {
    _token = newToken;

    Modular.get<SharedLocalStorageService>().put('fidelin/token', _token!);
  }

  String getToken() {
    return _token!;
  }
}
