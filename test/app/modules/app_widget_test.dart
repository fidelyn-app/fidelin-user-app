import 'package:asuka/asuka.dart';
import 'package:fidelin_user_app/app/app_module.dart';
import 'package:fidelin_user_app/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockModularNavigate extends Mock implements IModularNavigator {}

void main() {
  late IModularNavigator modularNavigate;

  setUpAll(() {
    modularNavigate = MockModularNavigate();
    Modular.navigatorDelegate = modularNavigate;
    Modular.setInitialRoute('/splash');
  });

  setUp(() async {
    await dotenv.load(fileName: ".env");
    Modular.init(AppModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group('AppWidget', () {
    testWidgets('Deve renderizar o MaterialApp com o título correto', (
      tester,
    ) async {
      when(
        () => modularNavigate.pushNamedAndRemoveUntil(any(), any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, 'Fidelyn User');
    });

    testWidgets('Deve usar o Asuka.builder no builder do MaterialApp', (
      tester,
    ) async {
      when(
        () => modularNavigate.pushNamedAndRemoveUntil(any(), any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.builder, equals(Asuka.builder));
    });

    testWidgets('Deve usar o Modular.routeInformationParser', (tester) async {
      when(
        () => modularNavigate.pushNamedAndRemoveUntil(any(), any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(
        materialApp.routeInformationParser,
        equals(Modular.routeInformationParser),
      );
    });

    testWidgets('Deve usar o Modular.routerDelegate', (tester) async {
      when(
        () => modularNavigate.pushNamedAndRemoveUntil(any(), any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(const AppWidget());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routerDelegate, equals(Modular.routerDelegate));
    });
  });
}
