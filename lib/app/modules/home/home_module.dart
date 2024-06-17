import 'package:fidelin_user_app/app/modules/home/home_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/pages/cards_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/profile/presentation/pages/profile_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/qrcode/presentation/pages/qr_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage(), children: [
      ChildRoute('/cards', child: (context) => const CardsPage()),
      ChildRoute('/profile', child: (context) => const ProfilePage()),
      ChildRoute('/qr', child: (context) => const QrPage()),
    ]);
  }
}
