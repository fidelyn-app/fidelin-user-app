import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/usecases/fetch_history_usecase.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  late FetchHistoryUseCase _fetchHistoryUseCase;

  _HistoryControllerBase({required FetchHistoryUseCase fetchHistoryUseCase}) {
    _fetchHistoryUseCase = fetchHistoryUseCase;
  }

  @observable
  ObservableList<UserCard> historyCards = ObservableList<UserCard>();

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingMore = false;

  @observable
  bool hasMore = true;

  @observable
  int currentPage = 1;

  static const int perPage = 10;

  @action
  Future<void> fetchHistory({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMore) return;
      isLoadingMore = true;
    } else {
      if (isLoading) return;
      isLoading = true;
      currentPage = 1;
      hasMore = true;
      historyCards.clear();
    }

    final Either<Exception, dynamic> response = await _fetchHistoryUseCase.call(
      page: currentPage,
      perPage: perPage,
    );

    response.fold(
      (Exception e) {
        if (!loadMore) {
          AsukaSnackbar.alert("Erro ao carregar histórico.").show();
        }
      },
      (historyResponse) {
        historyCards.addAll(historyResponse.items);
        currentPage++;
        hasMore = currentPage <= historyResponse.meta.totalPages;
      },
    );

    if (loadMore) {
      isLoadingMore = false;
    } else {
      isLoading = false;
    }
  }

  @action
  Future<void> loadMore() async {
    await fetchHistory(loadMore: true);
  }
}
