import 'package:mobx/mobx.dart';

import '../domain/entities/user_entity.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserEntity? user;

  @computed
  bool get isLogged => user != null;

  @action
  Future<void> setUser(UserEntity userEntity) async {
    user = userEntity;
  }

  @action
  Future<void> removeUser() async {
    user = null;
  }

  @action
  Future<bool> check() async {
    return false;
  }
}
