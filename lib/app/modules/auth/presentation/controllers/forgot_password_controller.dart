import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/update_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordControllerBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordControllerBase with Store {
  late ForgotPasswordUseCase _forgotPasswordUseCase;
  late UpdatePasswordUseCase _updatePasswordUseCase;

  _ForgotPasswordControllerBase(
      {required ForgotPasswordUseCase forgotPasswordUseCase,
      required UpdatePasswordUseCase updatePasswordUseCase}) {
    _forgotPasswordUseCase = forgotPasswordUseCase;
    _updatePasswordUseCase = updatePasswordUseCase;
  }

  final formField = GlobalKey<FormState>();

  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController codeTextController = TextEditingController();

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

  @observable
  bool isLoading = false;

  String? passwordEquals(String? value) {
    if (passwordTextController.text != confirmPasswordTextController.text) {
      return 'As senhas devem ser iguais';
    }

    if (value!.isEmpty) {
      return 'Insira uma senha';
    }
    bool passwordValid = RegExp(r"(?=.{8,})").hasMatch(value);
    if (!passwordValid) {
      return "Insira uma senha válida (deve conter 8 caracteres)";
    }
    return null;
  }

  @action
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  @action
  void toggleConfirmPasswordVisible() {
    confirmPasswordVisible = !confirmPasswordVisible;
  }

  @action
  Future<void> requestForgotPassword() async {
    formField.currentState!.validate();
    if (formField.currentState!.validate()) {
      isLoading = true;
      final Either<Failure, Unit> response = await _forgotPasswordUseCase.call(
        email: emailTextController.text,
      );
      response.fold((Failure e) {
        AsukaSnackbar.alert(e.message).show();
      }, (_) {
        Modular.to.pushNamed('/auth/check-email');
      });
      isLoading = false;
    }
  }

  @action
  Future<void> updatePassword() async {
    isLoading = true;
    final Either<Failure, Unit> response = await _updatePasswordUseCase.call(
        email: emailTextController.text,
        code: codeTextController.text,
        password: passwordTextController.text);
    response.fold((Failure e) {
      AsukaSnackbar.alert(e.message).show();
    }, (_) {
      Modular.to.popUntil((route) => route.isFirst);
    });
    isLoading = false;
  }
}
