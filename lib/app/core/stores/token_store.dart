import 'package:mobx/mobx.dart';

part 'token_store.g.dart';

class TokenStore = _TokenStoreBase with _$TokenStore;

abstract class _TokenStoreBase with Store {
  @observable
  String? token;

  @action
  void setToken(String? newToken) {
    token = newToken;
  }
}
