// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$cardsAtom =
      Atom(name: '_HomeControllerBase.cards', context: context);

  @override
  ObservableList<UserCard> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<UserCard> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeControllerBase.isLoading', context: context);

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

  late final _$fetchUserCardsAsyncAction =
      AsyncAction('_HomeControllerBase.fetchUserCards', context: context);

  @override
  Future<void> fetchUserCards() {
    return _$fetchUserCardsAsyncAction.run(() => super.fetchUserCards());
  }

  late final _$addPointAsyncAction =
      AsyncAction('_HomeControllerBase.addPoint', context: context);

  @override
  Future<void> addPoint({required String shortCodeId}) {
    return _$addPointAsyncAction
        .run(() => super.addPoint(shortCodeId: shortCodeId));
  }

  late final _$addCardAsyncAction =
      AsyncAction('_HomeControllerBase.addCard', context: context);

  @override
  Future<void> addCard({required String shortCodeId}) {
    return _$addCardAsyncAction
        .run(() => super.addCard(shortCodeId: shortCodeId));
  }

  late final _$deleteCardAsyncAction =
      AsyncAction('_HomeControllerBase.deleteCard', context: context);

  @override
  Future<void> deleteCard({required String cardId}) {
    return _$deleteCardAsyncAction.run(() => super.deleteCard(cardId: cardId));
  }

  @override
  String toString() {
    return '''
cards: ${cards},
isLoading: ${isLoading}
    ''';
  }
}
