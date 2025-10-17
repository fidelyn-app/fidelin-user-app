import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_card_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_point_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/delete_card_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/fetch_cards_usecase.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late FetchCardsUseCase _fetchCardsUseCase;
  late AddCardUseCase _addCardUseCase;
  late AddPointUseCase _addPointUseCase;
  late DeleteCardUseCase _deleteCardUseCase;

  _HomeControllerBase({
    required FetchCardsUseCase fetchCardsUseCase,
    required AddCardUseCase addCardUseCase,
    required AddPointUseCase addPointUseCase,
    required DeleteCardUseCase deleteCardUseCase,
  }) {
    _fetchCardsUseCase = fetchCardsUseCase;
    _addCardUseCase = addCardUseCase;
    _addPointUseCase = addPointUseCase;
    _deleteCardUseCase = deleteCardUseCase;
  }

  @observable
  ObservableList<UserCard> cards = ObservableList<UserCard>();

  int indexCard = 0;

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchUserCards() async {
    isLoading = true;

    final Either<Exception, List<UserCard>> response =
        await _fetchCardsUseCase.call();
    response.fold((Exception e) {}, (List<UserCard> listOfCards) {
      cards.clear();
      cards.addAll(listOfCards);
    });

    // List<UserCard> fakerUserCards =
    //     List.generate(3, (i) => EntityGenerator.generateUserCard());

    // final card = EntityGenerator.generateUserCard();

    // cards.addAll(fakerUserCards);

    // print(fakerUserCards[0].card.maxPoints);

    isLoading = false;
  }

  Future<void> onFocusCard(int index) async {
    indexCard = index;
  }

  @action
  Future<void> addPoint({required String shortCodeId}) async {
    isLoading = true;

    final Either<Exception, Unit> response = await _addPointUseCase.call(
      pointId: shortCodeId,
      cardId: cards[indexCard].id,
    );
    response.fold(
      (Exception e) {
        isLoading = false;
      },
      (_) {
        fetchUserCards();
      },
    );
  }

  @action
  Future<void> addCard({required String shortCodeId}) async {
    isLoading = true;

    final Either<Exception, Unit> response = await _addCardUseCase.call(
      cardId: shortCodeId,
    );
    response.fold(
      (Exception e) {
        isLoading = false;
      },
      (_) {
        fetchUserCards();
      },
    );
  }

  @action
  Future<void> deleteCard({required String cardId}) async {
    isLoading = true;

    final Either<Exception, Unit> response = await _deleteCardUseCase.call(
      cardId: cardId,
    );
    response.fold(
      (Exception e) {
        isLoading = false;
        AsukaSnackbar.alert("Não foi possível deletar o cartão.").show();
      },
      (_) {
        fetchUserCards();
      },
    );
  }
}
