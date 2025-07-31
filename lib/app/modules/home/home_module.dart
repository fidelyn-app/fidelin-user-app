import 'package:fidelin_user_app/app/modules/home/data/data/datasources/cards_datasource.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/datasources/cards_datasource_impl.dart';
import 'package:fidelin_user_app/app/modules/home/data/data/repositories/cards_repository_impl.dart';
import 'package:fidelin_user_app/app/modules/home/domain/repositories/cards_repository.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_card_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_point_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/fetch_cards_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/home_page.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/input_code_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/cards_page.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/input_code.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/profile_page.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/qr_scanner_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<CardsDataSource>(
      () => CardsDataSourceImpl(baseUrl: dotenv.env['API_URL']!),
    );

    i.add<CardsRepository>(CardsRepositoryImpl.new);

    i.add<FetchCardsUseCase>(FetchCardsUseCaseImpl.new);
    i.add<AddCardUseCase>(AddCardUseCaseImpl.new);
    i.add<AddPointUseCase>(AddPointUseCaseImpl.new);

    i.addSingleton(HomeController.new);
    i.addSingleton(InputCodeController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/input_code',
      child: (context) => InputCode(type: r.args.queryParams['type']),
    );
    r.child('/qr', child: (context) => const QRScannerPage());
    r.child(
      '/',
      child: (context) => const HomePage(),
      children: [
        ChildRoute('/cards', child: (context) => CardsPage()),
        ChildRoute('/profile', child: (context) => const ProfilePage()),
      ],
    );
  }
}
