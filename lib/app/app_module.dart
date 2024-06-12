import 'package:fidelin_user_app/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
  }
}
