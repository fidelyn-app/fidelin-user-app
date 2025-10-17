// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStoreBase, Store {
  Computed<bool>? _$isLoggedComputed;

  @override
  bool get isLogged => (_$isLoggedComputed ??=
          Computed<bool>(() => super.isLogged, name: '_AppStoreBase.isLogged'))
      .value;

  late final _$userAtom = Atom(name: '_AppStoreBase.user', context: context);

  @override
  UserEntity? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_tokenAtom =
      Atom(name: '_AppStoreBase._token', context: context);

  @override
  String? get _token {
    _$_tokenAtom.reportRead();
    return super._token;
  }

  @override
  set _token(String? value) {
    _$_tokenAtom.reportWrite(value, super._token, () {
      super._token = value;
    });
  }

  late final _$appVersionAtom =
      Atom(name: '_AppStoreBase.appVersion', context: context);

  @override
  String? get appVersion {
    _$appVersionAtom.reportRead();
    return super.appVersion;
  }

  @override
  set appVersion(String? value) {
    _$appVersionAtom.reportWrite(value, super.appVersion, () {
      super.appVersion = value;
    });
  }

  late final _$setUserAsyncAction =
      AsyncAction('_AppStoreBase.setUser', context: context);

  @override
  Future<void> setUser(UserEntity userEntity) {
    return _$setUserAsyncAction.run(() => super.setUser(userEntity));
  }

  late final _$removeUserAsyncAction =
      AsyncAction('_AppStoreBase.removeUser', context: context);

  @override
  Future<void> removeUser() {
    return _$removeUserAsyncAction.run(() => super.removeUser());
  }

  late final _$checkAsyncAction =
      AsyncAction('_AppStoreBase.check', context: context);

  @override
  Future<bool> check() {
    return _$checkAsyncAction.run(() => super.check());
  }

  late final _$loadAppVersionAsyncAction =
      AsyncAction('_AppStoreBase.loadAppVersion', context: context);

  @override
  Future<void> loadAppVersion() {
    return _$loadAppVersionAsyncAction.run(() => super.loadAppVersion());
  }

  late final _$checkFirstRunAsyncAction =
      AsyncAction('_AppStoreBase.checkFirstRun', context: context);

  @override
  Future<bool> checkFirstRun() {
    return _$checkFirstRunAsyncAction.run(() => super.checkFirstRun());
  }

  late final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase', context: context);

  @override
  void setToken(String newToken) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.setToken');
    try {
      return super.setToken(newToken);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
appVersion: ${appVersion},
isLogged: ${isLogged}
    ''';
  }
}
