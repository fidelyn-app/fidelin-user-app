// ignore_for_file: depend_on_referenced_packages

import 'dart:math' as math;

import 'package:faker/faker.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/card_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/point_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/reward_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/store_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/style_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/time_to_expire_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelyn_user_app/utils/color_mapper.dart';

class EntityGenerator {
  static Reward generateReward({String? storeId}) {
    return Reward(
      id: faker.guid.guid(),
      pointsRequired: faker.randomGenerator.integer(24),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      expirationModel:
          ExpirationModelEnum.values[faker.randomGenerator.integer(
            ExpirationModelEnum.values.length,
          )],
      timeToExpire:
          faker.randomGenerator.boolean()
              ? TimeToExpire(
                days: faker.randomGenerator.integer(30),
                hours: faker.randomGenerator.integer(23),
              )
              : null,
      dateToExpire:
          faker.randomGenerator.boolean()
              ? faker.date.dateTime(minYear: 2025, maxYear: 2060)
              : null,
      storeId: storeId ?? faker.guid.guid(),
      //active: faker.randomGenerator.boolean(),
    );
  }

  static UserCard generateUserCard() {
    final faker = Faker();
    final pointsCount = faker.randomGenerator.integer(24);
    // Generate random values for UserCard properties
    return UserCard(
      id: faker.guid.guid(),
      expiration: faker.date.dateTime(minYear: 2023, maxYear: 2025),
      pointsCount: pointsCount,
      userId: faker.guid.guid(),
      card: generateCard(), // Assuming you have a similar function for Card
      points: List.generate(
        faker.randomGenerator.integer(pointsCount),
        (_) => generatePoint(),
      ),
      shortCode: faker.randomGenerator.string(6).toUpperCase(),
      reward: generateReward(),
    );
  }

  static Style generateStyle() {
    return Style(
      id: faker.guid.guid(),
      colorPrimary: ColorMapper.hexToColor(_generateRandomHexColor()),
      colorSecondary: ColorMapper.hexToColor(_generateRandomHexColor()),
      pointShowNumbers: faker.randomGenerator.boolean(),
      pointBorderRadius: double.parse(
        (faker.randomGenerator.integer(200, min: 0) / 10).toStringAsFixed(2),
      ),
      backgroundUrl: 'https://picsum.photos/400/600',
      title: faker.company.person.firstName(),
      subtitle: faker.company.person.lastName(),
    );
  }

  static Card generateCard() {
    final faker = Faker();
    final storeId = faker.guid.guid();

    // Generate random values for Card properties
    return Card(
      id: faker.guid.guid(),
      //active: faker.randomGenerator.boolean(),
      storeId: storeId,
      timeToExpire: TimeToExpire(months: faker.randomGenerator.integer(24)),
      store: generateStore(storeId: storeId),
      style: generateStyle(),
    );
  }

  static Store generateStore({String? storeId}) {
    final faker = Faker();

    // Generate random values for Store properties
    return Store(
      id: storeId ?? faker.guid.guid(),
      businessName: faker.company.name(),
      legalName: faker.company.name(),
      taxId: '00.000.000/0000-00', // Assuming taxId follows ISBN-13 format
      email: faker.internet.email(),
      avatarUrl:
          'https://picsum.photos/200', // Assuming you want random image URLs
      phone: faker.phoneNumber.toString(),
      active: faker.randomGenerator.boolean(),
      stripeId: faker.guid.guid(),
      contacts: generateContacts(),
    );
  }

  static Contacts generateContacts() {
    final faker = Faker();

    // Generate random values for Contacts properties (some might be null)
    return Contacts(
      instagram: '@${faker.internet.userName()}',
      phone: faker.phoneNumber.toString(),
      site: 'http://${faker.internet.domainName()}',
      whatsapp: faker.randomGenerator.boolean(),
    );
  }

  static Point generatePoint() {
    final faker = Faker();

    // Generate random values for Point properties
    return Point(id: faker.guid.guid(), used: faker.randomGenerator.boolean());
  }

  static String _generateRandomHexColor() {
    final random = math.Random();
    final red = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    final green = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    final blue = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    return '#$red$green$blue';
  }
}
