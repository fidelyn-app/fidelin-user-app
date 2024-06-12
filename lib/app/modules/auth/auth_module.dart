import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signin_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/signin_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    i.addSingleton(() => SignInController());
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SignInPage());
  }
}
