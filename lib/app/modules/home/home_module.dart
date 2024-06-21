import 'package:fidelin_user_app/app/modules/home/home_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/controllers/cards_controller.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/pages/cards_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/profile/presentation/pages/profile_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/qrcode/presentation/controller/qrcode_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    // i.add<AuthDataSource>(() => AuthDataSourceImpl(dotenv.env['BASE_URL']!));

    // i.add<AuthRepository>(AuthRepositoryImpl.new);

    // i.add<SignInWithEmailUseCase>(SignInWithEmailUseCaseImpl.new);
    // i.add<SignUpWithEmailUseCase>(SignUpWithEmailUseCaseImpl.new);

    // i.addSingleton(SignInController.new);
    // i.addSingleton(SignUpController.new);
    i.addSingleton(CardsController.new);
    i.addSingleton(QrCodeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage(), children: [
      ChildRoute('/cards', child: (context) => CardsPage()),
      ChildRoute('/profile', child: (context) => const ProfilePage()),
      //ChildRoute('/qr', child: (context) => const QRCodePage()),
    ]);
  }
}
