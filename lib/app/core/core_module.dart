import 'package:fidelin_user_app/app/core/stores/token_store.dart';
import 'package:fidelin_user_app/app/core/stores/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(UserStore.new);
    i.addSingleton(TokenStore.new);
  }
}
