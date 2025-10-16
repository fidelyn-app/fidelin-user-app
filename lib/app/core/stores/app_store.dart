import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/services/shared_local_storage_service.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/data/mapper/user_mapper.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  @observable
  UserEntity? user;
  @observable
  String? _token;

  @observable
  String? appVersion;

  @computed
  bool get isLogged => user != null;

  final SharedLocalStorageService _sharedPreferences =
      Modular.get<SharedLocalStorageService>();

  _AppStoreBase() {
    loadAppVersion();
  }

  @action
  Future<void> setUser(UserEntity userEntity) async {
    user = userEntity;

    var userMapped = UserMapper.mapEntityToDTO(userEntity);

    Modular.get<SharedLocalStorageService>().put(
      'fidelyn/user',
      userMapped.toJSON(),
    );
  }

  @action
  Future<void> removeUser() async {
    user = null;
    _token = null;

    _sharedPreferences.delete('fidelyn/user');
    _sharedPreferences.delete('fidelyn/token');
  }

  @action
  Future<bool> check() async {
    String? userJSON = await Modular.get<SharedLocalStorageService>().get(
      'fidelyn/user',
    );
    String? tokenJSON = await Modular.get<SharedLocalStorageService>().get(
      'fidelyn/token',
    );

    if (userJSON == null && tokenJSON == null) {
      return false;
    }

    UserDTO.fromJSON(userJSON!);

    user = UserMapper.mapDTOtoEntity(UserDTO.fromJSON(userJSON));
    _token = tokenJSON;

    return true;
  }

  @action
  void setToken(String newToken) {
    _token = newToken;

    _sharedPreferences.put('fidelyn/token', _token!);
  }

  String getToken() {
    return _token!;
  }

  @action
  Future<void> loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = info.version;
  }

  @action
  Future<bool> checkFirstRun() async {
    return true;
    final hasRunBefore =
        await _sharedPreferences.get('fidelyn/hasRunBefore') ?? false;

    if (!hasRunBefore) {
      await _sharedPreferences.put('fidelyn/hasRunBefore', true);
      return true;
    } else {
      return false;
    }
  }
}
