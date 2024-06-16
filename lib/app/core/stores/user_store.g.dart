// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  Computed<bool>? _$isLoggedComputed;

  @override
  bool get isLogged => (_$isLoggedComputed ??=
          Computed<bool>(() => super.isLogged, name: '_UserStoreBase.isLogged'))
      .value;

  late final _$userAtom = Atom(name: '_UserStoreBase.user', context: context);

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

  late final _$setUserAsyncAction =
      AsyncAction('_UserStoreBase.setUser', context: context);

  @override
  Future<void> setUser(UserEntity userEntity) {
    return _$setUserAsyncAction.run(() => super.setUser(userEntity));
  }

  late final _$removeUserAsyncAction =
      AsyncAction('_UserStoreBase.removeUser', context: context);

  @override
  Future<void> removeUser() {
    return _$removeUserAsyncAction.run(() => super.removeUser());
  }

  late final _$checkAsyncAction =
      AsyncAction('_UserStoreBase.check', context: context);

  @override
  Future<bool> check() {
    return _$checkAsyncAction.run(() => super.check());
  }

  @override
  String toString() {
    return '''
user: ${user},
isLogged: ${isLogged}
    ''';
  }
}
