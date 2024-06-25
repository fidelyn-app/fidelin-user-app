import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/fetch_cards_usecase.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late FetchCardsUseCase _fetchCardsUseCase;

  _HomeControllerBase({required FetchCardsUseCase fetchCardsUseCase}) {
    _fetchCardsUseCase = fetchCardsUseCase;
  }

  @observable
  ObservableList<UserCard> cards = ObservableList<UserCard>();

  int indexCard = 0;

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchUserCards() async {
    isLoading = true;

    final Either<Exception, List<UserCard>> _response =
        await _fetchCardsUseCase.call();
    _response.fold(
      (Exception e) {
        print("ERROR");
      },
      (List<UserCard> listOfCards) {
        cards.clear();
        cards.addAll(listOfCards);
      },
    );

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
  Future<void> addPoint(String id) async {
    print('ADICIONANDO PONTO $id index $indexCard');
  }

  @action
  Future<void> addCard(String id) async {
    print('ADICIONANDO CARTÃO $id index $indexCard');
  }
}
