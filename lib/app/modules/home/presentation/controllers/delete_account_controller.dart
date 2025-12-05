import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/usecases/delete_account_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'delete_account_controller.g.dart';

class DeleteAccountController = _DeleteAccountControllerBase
    with _$DeleteAccountController;

abstract class _DeleteAccountControllerBase with Store {
  final DeleteAccountUseCase _deleteAccountUseCase;

  final AppStore _appStore = Modular.get<AppStore>();

  _DeleteAccountControllerBase(this._deleteAccountUseCase);

  @observable
  bool isLoading = false;

  @observable
  bool success = false;

  @observable
  String? error;

  @action
  Future<void> deleteAccount() async {
    isLoading = true;
    error = null;
    success = false;

    final result = await _deleteAccountUseCase(_appStore.user!.id);

    result.fold(
      (failure) {
        error = failure.message;
        success = false;
        AsukaSnackbar.alert(
          "Não foi possível deletar a conta. Tente novamente mais tarde.",
        ).show();
        isLoading = false;
      },
      (_) {
        _appStore.removeUser();
        Modular.to.pushNamedAndRemoveUntil("/auth/", (_) => false);
        success = true;
        AsukaSnackbar.success("Conta deletada com sucesso!").show();
      },
    );
  }
}
