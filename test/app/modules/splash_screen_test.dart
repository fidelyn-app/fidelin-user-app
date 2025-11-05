import 'package:fidelin_user_app/app/app_module.dart';
import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppStore extends Mock implements AppStore {}

class MockModularNavigate extends Mock implements IModularNavigator {}

void main() {
  late AppStore appStore;
  late IModularNavigator modularNavigate;

  setUpAll(() {
    modularNavigate = MockModularNavigate();
    Modular.navigatorDelegate = modularNavigate;
  });

  setUp(() async {
    modularNavigate = MockModularNavigate();
    Modular.navigatorDelegate = modularNavigate;

    appStore = MockAppStore();
    await dotenv.load(fileName: ".env");
    Modular.replaceInstance<AppStore>(appStore);
    Modular.init(AppModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group('SplashScreen', () {
    testWidgets('Deve exibir o logo na tela de splash', (tester) async {
      when(() => appStore.check()).thenAnswer((_) async => false);
      when(() => appStore.checkFirstRun()).thenAnswer((_) async => false);
      when(
        () => modularNavigate.pushNamedAndRemoveUntil(any(), any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

      expect(find.byType(Image), findsOneWidget);
      expect(
        find.image(const AssetImage('assets/app/splash-screen.png')),
        findsOneWidget,
      );
    });

    testWidgets(
      'Deve navegar para /home/ se houver credenciais salvas e não for a primeira execução',
      (tester) async {
        when(() => appStore.check()).thenAnswer((_) async => true);
        when(() => appStore.checkFirstRun()).thenAnswer((_) async => false);
        when(
          () => modularNavigate.pushNamedAndRemoveUntil('/home/', any()),
        ).thenAnswer((_) async => null);

        await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
        await tester.pumpAndSettle();

        verify(
          () => modularNavigate.pushNamedAndRemoveUntil('/home/', any()),
        ).called(1);
      },
    );

    testWidgets(
      'Deve navegar para /auth/intro se não houver credenciais salvas e for a primeira execução',
      (tester) async {
        when(() => appStore.check()).thenAnswer((_) async => false);
        when(() => appStore.checkFirstRun()).thenAnswer((_) async => true);
        when(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/intro', any()),
        ).thenAnswer((_) async => null);

        await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
        await tester.pumpAndSettle();

        verify(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/intro', any()),
        ).called(1);
      },
    );

    testWidgets(
      'Deve navegar para /auth/ se não houver credenciais salvas e não for a primeira execução',
      (tester) async {
        when(() => appStore.check()).thenAnswer((_) async => false);
        when(() => appStore.checkFirstRun()).thenAnswer((_) async => false);
        when(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/', any()),
        ).thenAnswer((_) async => null);

        await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
        await tester.pumpAndSettle();

        verify(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/', any()),
        ).called(1);
      },
    );

    testWidgets(
      'Deve navegar para /auth/ em caso de erro durante a verificação',
      (tester) async {
        when(() => appStore.check()).thenThrow(Exception('Erro de teste'));
        when(() => appStore.checkFirstRun()).thenAnswer((_) async => false);
        when(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/', any()),
        ).thenAnswer((_) async => null);

        await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
        await tester.pumpAndSettle();

        verify(
          () => modularNavigate.pushNamedAndRemoveUntil('/auth/', any()),
        ).called(1);
      },
    );
  });
}
