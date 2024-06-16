import 'package:fidelin_user_app/app/core/core_module.dart';
import 'package:fidelin_user_app/app/core/guards/auth_guard.dart';
import 'package:fidelin_user_app/app/modules/auth/auth_module.dart';
import 'package:fidelin_user_app/app/modules/home/home_module.dart';
import 'package:fidelin_user_app/app/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/splash', child: (context) => SplashScreen());
    r.module('/auth/', module: AuthModule());
    r.module('/home/', module: HomeModule(), guards: [AuthGuard()]);
  }
}
