import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_card_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_point_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/fetch_cards_usecase.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late FetchCardsUseCase _fetchCardsUseCase;
  late AddCardUseCase _addCardUseCase;
  late AddPointUseCase _addPointUseCase;

  _HomeControllerBase({
    required FetchCardsUseCase fetchCardsUseCase,
    required AddCardUseCase addCardUseCase,
    required AddPointUseCase addPointUseCase,
  }) {
    _fetchCardsUseCase = fetchCardsUseCase;
    _addCardUseCase = addCardUseCase;
    _addPointUseCase = addPointUseCase;
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
  Future<void> addPoint(String pointId) async {
    isLoading = true;

    final Either<Exception, Unit> response = await _addPointUseCase.call(
      pointId: pointId,
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
  Future<void> addCard(String cardId) async {
    isLoading = true;

    final Either<Exception, Unit> response = await _addCardUseCase.call(
      cardId: cardId,
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
}
