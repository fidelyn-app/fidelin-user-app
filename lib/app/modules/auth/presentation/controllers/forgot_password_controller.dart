import 'package:mobx/mobx.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordControllerBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordControllerBase with Store {
  @observable
  bool loading = false;

  @action
  Future<bool> requestForgotPassword({required String email}) async {
    //loading = true;

    return true;
  }
}
