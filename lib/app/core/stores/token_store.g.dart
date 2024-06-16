// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TokenStore on _TokenStoreBase, Store {
  late final _$tokenAtom =
      Atom(name: '_TokenStoreBase.token', context: context);

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$_TokenStoreBaseActionController =
      ActionController(name: '_TokenStoreBase', context: context);

  @override
  void setToken(String? newToken) {
    final _$actionInfo = _$_TokenStoreBaseActionController.startAction(
        name: '_TokenStoreBase.setToken');
    try {
      return super.setToken(newToken);
    } finally {
      _$_TokenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token}
    ''';
  }
}
