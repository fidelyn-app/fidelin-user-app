import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';

class HistoryResponse {
  final List<UserCard> items;
  final HistoryMeta meta;

  HistoryResponse({required this.items, required this.meta});
}

class HistoryMeta {
  final int total;
  final int page;
  final int perPage;
  final int totalPages;

  HistoryMeta({
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
  });
}
