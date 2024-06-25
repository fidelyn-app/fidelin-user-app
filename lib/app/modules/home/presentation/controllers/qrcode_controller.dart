// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'qrcode_controller.g.dart';

class QrCodeController = _QrCodeControllerBase with _$QrCodeController;

abstract class _QrCodeControllerBase with Store {
  //late AddPointUseCase _addPointUseCase;

  // _QrCodeControllerBase({required AddPointUseCase addPointUseCase}) {
  //   _addPointUseCase = addPointUseCase;
  // }

  @observable
  bool isLoading = false;

  @action
  Future<void> addPoint(String id) async {}

  @action
  Future<void> addCard(String id) async {}
}
