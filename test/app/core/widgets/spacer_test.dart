import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:flutter/material.dart' hide Spacer;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Spacer', () {
    test('fromSize deve retornar o valor correto para SpaceSize.xs', () {
      // ignore: prefer_const_constructors
      expect(AppSpacer.fromSize(SpaceSize.xs), equals(2.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.s', () {
      expect(AppSpacer.fromSize(SpaceSize.s), equals(4.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.m', () {
      expect(AppSpacer.fromSize(SpaceSize.m), equals(8.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.l', () {
      expect(AppSpacer.fromSize(SpaceSize.l), equals(16.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.xl', () {
      expect(AppSpacer.fromSize(SpaceSize.xl), equals(32.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.xxl', () {
      expect(AppSpacer.fromSize(SpaceSize.xxl), equals(48.0));
    });

    test('fromSize deve retornar o valor correto para SpaceSize.xxxl', () {
      expect(AppSpacer.fromSize(SpaceSize.xxxl), equals(64.0));
    });
  });

  group('SpaceWidget', () {
    testWidgets(
      'Deve renderizar um SizedBox com a altura correta para SpaceSize.m',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: SpaceWidget(size: SpaceSize.m)),
          ),
        );

        final sizedBoxFinder = find.byType(SizedBox);
        expect(sizedBoxFinder, findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.height, equals(8.0));
      },
    );

    testWidgets(
      'Deve renderizar um SizedBox com a largura correta para SpaceSize.l',
      (tester) async {
        await tester.pumpWidget(
          // ignore: prefer_const_constructors
          MaterialApp(
            home: Scaffold(
              body: SpaceWidget(size: SpaceSize.l, axis: Axis.horizontal),
            ),
          ),
        );

        final sizedBoxFinder = find.byType(SizedBox);
        expect(sizedBoxFinder, findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.width, equals(16.0));
      },
    );

    testWidgets(
      'Deve renderizar um SizedBox com altura e largura nulas para SpaceSize.m quando horizontal',
      (tester) async {
        await tester.pumpWidget(
          // ignore: prefer_const_constructors
          MaterialApp(
            home: Scaffold(
              body: SpaceWidget(size: SpaceSize.m, axis: Axis.horizontal),
            ),
          ),
        );

        final sizedBoxFinder = find.byType(SizedBox);
        expect(sizedBoxFinder, findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.height, isNull);
      },
    );

    testWidgets(
      'Deve renderizar um SizedBox com altura e largura nulas para SpaceSize.l quando vertical',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: SpaceWidget(size: SpaceSize.l)),
          ),
        );

        final sizedBoxFinder = find.byType(SizedBox);
        expect(sizedBoxFinder, findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);
        expect(sizedBox.width, isNull);
      },
    );
  });
}
