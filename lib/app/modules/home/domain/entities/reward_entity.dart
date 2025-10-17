// ignore_for_file: constant_identifier_names

import 'time_to_expire_entity.dart';

enum ExpirationModelEnum { DATE_TO_EXPIRE, TIME_TO_EXPIRE, NONE }

class Reward {
  final String id;
  final String title;
  final String? description;
  final int pointsRequired;
  final ExpirationModelEnum expirationModel;
  final TimeToExpire? timeToExpire;
  final DateTime? dateToExpire;
  final String storeId;
  final bool active;

  Reward({
    required this.id,
    required this.title,
    this.description,
    required this.pointsRequired,
    required this.expirationModel,
    this.timeToExpire,
    this.dateToExpire,
    required this.storeId,
    required this.active,
  });

  @override
  String toString() {
    return '''
    Store(
      id: $id,
      title: $title,
      description: ${description ?? 'Not provided'},
      pointsRequired: $pointsRequired,
      expirationModel: $expirationModel,
      timeToExpire: $timeToExpire,
      dateToExpire: $dateToExpire,
      storeId: $storeId,
      active: $active,
    )
   ''';
  }
}
