import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_card_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/domain/usecases/add_point_usecase.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:mobx/mobx.dart';

part 'input_code_controller.g.dart';

class InputCodeController = _InputCodeControllerBase with _$InputCodeController;

abstract class _InputCodeControllerBase with Store {
  late AddCardUseCase _addCardUseCase;
  late AddPointUseCase _addPointUseCase;
  late HomeController _homeController;

  _InputCodeControllerBase({
    required AddCardUseCase addCardUseCase,
    required AddPointUseCase addPointUseCase,
    required HomeController homeController,
  }) {
    _addCardUseCase = addCardUseCase;
    _addPointUseCase = addPointUseCase;
    _homeController = homeController;
  }

  @observable
  bool isLoading = false;

  @observable
  bool success = false;

  @observable
  bool error = false;

  @action
  Future<void> addPoint({required String shortCodeId}) async {
    isLoading = true;

    final cardId = _homeController.cards[_homeController.indexCard].id;

    final Either<Exception, Unit> response = await _addPointUseCase.call(
      pointId: shortCodeId,
      cardId: cardId,
    );
    response.fold(
      (Exception e) {
        error = true;
        success = false;
      },
      (_) {
        success = true;
        error = false;
        _homeController.fetchUserCards();
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
        error = true;
        success = false;
      },
      (_) {
        success = true;
        error = false;
        _homeController.fetchUserCards();
      },
    );
  }
}
