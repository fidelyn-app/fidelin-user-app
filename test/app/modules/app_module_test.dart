import 'package:fidelin_user_app/app/app_module.dart';
import 'package:fidelin_user_app/app/core/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppModule appModule;
  late RouteManager routeManager;
  //late List<ModularRoute> routes;

  setUp(() {
    appModule = AppModule();
    //routes = [];
    routeManager = RouteManager();
    appModule.routes(routeManager);
  });

  group('AppModule', () {
    test('Deve importar o CoreModule', () {
      expect(appModule.imports.any((m) => m is CoreModule), isTrue);
    });

    // test('Deve registrar rota /splash com SplashScreen', () {
    //   final route = routes.firstWhere(
    //     (r) => r.name == '/splash',
    //     orElse: () => throw Exception('Rota /splash não encontrada'),
    //   );

    //   expect(route.children, isNotNull);
    //   expect(route.children, isA<SplashScreen>());
    // });

    // test('Deve registrar módulo AuthModule na rota /auth/', () {
    //   final route = routes.firstWhere(
    //     (r) => r.name == '/auth/',
    //     orElse: () => throw Exception('Rota /auth/ não encontrada'),
    //   );

    //   expect(route.module, isA<AuthModule>());
    // });

    // test('Deve registrar módulo HomeModule na rota /home/ com AuthGuard', () {
    //   final route = routes.firstWhere(
    //     (r) => r.name == '/home/',
    //     orElse: () => throw Exception('Rota /home/ não encontrada'),
    //   );

    //   expect(route.module, isA<HomeModule>());
    //   expect(route.middlewares, isNotEmpty);
    //   expect(route.middlewares.first, isA<AuthGuard>());
    // });
  });
}
