import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signin_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signup_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/forgot_password_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/signup_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/signin_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => SignInController());
    i.addSingleton(() => SignUpController());
    i.addSingleton(() => ForgotPasswordController());
  }

  @override
  void routes(RouteManager r) {
    r.child('/',
        child: (context) => const SignInPage(),
        transition: TransitionType.fadeIn);
    r.child('/signup',
        child: (context) => const SignUpPage(),
        transition: TransitionType.fadeIn);
    r.child('/forgot-password',
        child: (context) => const ForgotPasswordPage(),
        transition: TransitionType.fadeIn);
  }
}
