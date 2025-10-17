import 'package:asuka/asuka.dart';
import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/core/domain/entities/user_entity.dart';
import 'package:fidelin_user_app/app/core/errors/Failure.dart';
import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/signin_with_email_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'signin_controller.g.dart';

class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store {
  late SignInWithEmailUseCase _signInWithEmailUseCase;

  final AppStore _userStore = Modular.get<AppStore>();

  _SignInControllerBase({
    required SignInWithEmailUseCase signInWithEmailUseCase,
  }) {
    _signInWithEmailUseCase = signInWithEmailUseCase;
  }

  final formField = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @action
  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
  }

  @action
  Future<void> signIn() async {
    formField.currentState!.validate();
    if (formField.currentState!.validate()) {
      loading = true;

      final Either<Failure, UserEntity> _response =
          await _signInWithEmailUseCase.call(
            email: emailTextController.text,
            password: passwordTextController.text,
          );
      _response.fold(
        (Failure e) {
          AsukaSnackbar.alert(e.message).show();
        },
        (UserEntity user) {
          _userStore.setUser(user);
          Modular.to.navigate('/home/');
        },
      );
      loading = false;
    }
  }
}
