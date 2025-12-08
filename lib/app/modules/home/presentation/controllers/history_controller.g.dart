// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryController on _HistoryControllerBase, Store {
  late final _$historyCardsAtom = Atom(
    name: '_HistoryControllerBase.historyCards',
    context: context,
  );

  @override
  ObservableList<UserCard> get historyCards {
    _$historyCardsAtom.reportRead();
    return super.historyCards;
  }

  @override
  set historyCards(ObservableList<UserCard> value) {
    _$historyCardsAtom.reportWrite(value, super.historyCards, () {
      super.historyCards = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_HistoryControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingMoreAtom = Atom(
    name: '_HistoryControllerBase.isLoadingMore',
    context: context,
  );

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
    });
  }

  late final _$hasMoreAtom = Atom(
    name: '_HistoryControllerBase.hasMore',
    context: context,
  );

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_HistoryControllerBase.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$fetchHistoryAsyncAction = AsyncAction(
    '_HistoryControllerBase.fetchHistory',
    context: context,
  );

  @override
  Future<void> fetchHistory({bool loadMore = false}) {
    return _$fetchHistoryAsyncAction.run(
      () => super.fetchHistory(loadMore: loadMore),
    );
  }

  late final _$loadMoreAsyncAction = AsyncAction(
    '_HistoryControllerBase.loadMore',
    context: context,
  );

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
historyCards: ${historyCards},
isLoading: ${isLoading},
isLoadingMore: ${isLoadingMore},
hasMore: ${hasMore},
currentPage: ${currentPage}
    ''';
  }
}
