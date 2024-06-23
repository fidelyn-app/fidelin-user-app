import 'package:fidelin_user_app/app/modules/home/home_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/datasources/cards_datasource.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/datasources/cards_datasource_impl.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/data/repositories/cards_repository_impl.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/repositories/cards_repository.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/usecases/fetch_cards_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/controllers/cards_controller.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/pages/cards_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/profile/presentation/pages/profile_page.dart';
import 'package:fidelin_user_app/app/modules/home/modules/qrcode/presentation/controller/qrcode_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<CardsDataSource>(
        () => CardsDataSourceImpl(dotenv.env['BASE_URL_STG']!));

    i.add<CardsRepository>(CardsRepositoryImpl.new);

    i.add<FetchCardsUseCase>(FetchCardsUseCaseImpl.new);

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
