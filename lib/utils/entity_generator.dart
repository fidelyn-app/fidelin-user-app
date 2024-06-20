// ignore_for_file: depend_on_referenced_packages

import 'dart:math' as math;

import 'package:faker/faker.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/point_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/store_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/utils/color_mapper.dart';

class EntityGenerator {
  static UserCard generateUserCard() {
    final faker = Faker();
    final pointsCount = faker.randomGenerator.integer(24);
    // Generate random values for UserCard properties
    return UserCard(
      id: faker.guid.guid(),
      expiration: faker.date.dateTime(minYear: 2023, maxYear: 2025),
      pointsCount: pointsCount,
      userId: faker.guid.guid(),
      createdAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      updatedAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      card: generateCard(), // Assuming you have a similar function for Card
      points: List.generate(
          faker.randomGenerator.integer(pointsCount),
          (_) =>
              generatePoint()), // Assuming you have a similar function for Point
    );
  }

  static Card generateCard() {
    final faker = Faker();

    // Generate random values for Card properties
    return Card(
      id: faker.guid.guid(),
      backgroundUrl: 'https://picsum.photos/400/600',
      maxPoints: faker.randomGenerator.integer(32, min: 8),
      color: ColorMapper.hexToColor(_generateRandomHexColor()),
      description: faker.lorem.sentence(),
      active: faker.randomGenerator.boolean(),
      storeId: faker.guid.guid(),
      timeToExpire: TimeToExpire(
          months: faker.randomGenerator.integer(24)), // Up to 2 years
      createdAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      updatedAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      store: generateStore(), // Assuming you have a similar function for Store
    );
  }

  static Store generateStore() {
    final faker = Faker();

    // Generate random values for Store properties
    return Store(
      id: faker.guid.guid(),
      businessName: faker.company.name(),
      legalName: faker.company.name(),
      taxId: '00.000.000/0000-00', // Assuming taxId follows ISBN-13 format
      email: faker.internet.email(),
      password: faker.internet
          .password(), // **Warning:** Consider hashing in real applications
      avatarUrl:
          'https://picsum.photos/200', // Assuming you want random image URLs
      phone: faker.phoneNumber.toString(),
      active: faker.randomGenerator.boolean(),
      stripeId: faker.guid.guid(),
      contacts: generateContacts(),
      createdAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      updatedAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
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
    return Point(
      id: faker.guid.guid(),
      used: faker.randomGenerator.boolean(),
      createdAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
      updatedAt: faker.date.dateTime(
          maxYear: DateTime.now().year, minYear: DateTime.now().year - 1),
    );
  }

  static String _generateRandomHexColor() {
    final random = math.Random();
    final red = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    final green = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    final blue = random.nextInt(256).toRadixString(16).padLeft(2, '0');
    return '#$red$green$blue';
  }
}
