import 'store_entity.dart';
import 'style_entity.dart';
import 'time_to_expire_entity.dart';

class Card {
  final String id;
  final bool active;
  final String storeId;
  final TimeToExpire? timeToExpire;
  final Store store;
  final Style style;

  Card({
    required this.id,
    required this.active,
    required this.storeId,
    required this.timeToExpire,
    required this.store,
    required this.style,
  });

  @override
  String toString() {
    return '''
      Card(
        id: $id,
        active: $active,
        storeId: $storeId,
        timeToExpire: $timeToExpire,
        store: ${store.toString()},
        style: ${style.toString()}
      )
      ''';
  }
}
