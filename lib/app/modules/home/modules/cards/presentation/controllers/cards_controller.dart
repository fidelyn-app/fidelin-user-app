import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/usecases/fetch_cards_usecase.dart';
import 'package:fidelin_user_app/utils/entity_generator.dart';
import 'package:mobx/mobx.dart';

part 'cards_controller.g.dart';

class CardsController = _CardsControllerBase with _$CardsController;

abstract class _CardsControllerBase with Store {
  late FetchCardsUseCase _fetchCardsUseCase;

  _CardsControllerBase({required FetchCardsUseCase fetchCardsUseCase}) {
    _fetchCardsUseCase = fetchCardsUseCase;
  }

  @observable
  ObservableList<UserCard> cards = ObservableList<UserCard>();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchUserCards() async {
    isLoading = true;

    final Either<Exception, List<UserCard>> _response =
        await _fetchCardsUseCase.call();
    _response.fold(
      (Exception e) {
        //print("error");
      },
      (List<UserCard> listOfCards) {
        // cards.clear();
        // cards.addAll(listOfCards);
      },
    );

    List<UserCard> fakerUserCards =
        List.generate(3, (i) => EntityGenerator.generateUserCard());

    cards.addAll(fakerUserCards);

    print(fakerUserCards[0].card.maxPoints);

    isLoading = false;
  }
}
