import 'package:fidelin_user_app/app/modules/auth/data/datasources/auth_datasource.dart';
import 'package:fidelin_user_app/app/modules/auth/data/datasources/auth_datasource_impl.dart';
import 'package:fidelin_user_app/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/signup_with_email_usercase.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/update_password_usecase.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signin_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signup_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/check_email_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/forgot_password_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/intro_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/privacy_policy_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/signup_page.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/pages/terms_and_conditions_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/signin_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.add<AuthDataSource>(
      () => AuthDataSourceImpl(baseUrl: dotenv.env['BASE_URL']!),
    );

    i.add<AuthRepository>(AuthRepositoryImpl.new);

    i.add<SignInWithEmailUseCase>(SignInWithEmailUseCaseImpl.new);
    i.add<SignUpWithEmailUseCase>(SignUpWithEmailUseCaseImpl.new);
    i.add<ForgotPasswordUseCase>(ForgotPasswordUseCaseImpl.new);
    i.add<UpdatePasswordUseCase>(UpdatePasswordUseCaseImpl.new);

    i.addSingleton(SignInController.new);
    i.addSingleton(SignUpController.new);
    i.addSingleton(ForgotPasswordController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SignInPage());
    r.child('/signup', child: (context) => const SignUpPage());
    r.child('/forgot-password', child: (context) => const ForgotPasswordPage());
    r.child('/check-email', child: (context) => const CheckEmailPage());
    r.child(
      '/terms-and-conditions',
      child: (context) => const TermsAndConditionsPage(),
    );
    r.child('/privacy-policy', child: (context) => const PrivacyPolicyPage());
    r.child('/intro', child: (context) => const IntroPage());
  }
}
