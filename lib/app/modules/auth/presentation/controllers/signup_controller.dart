import 'package:dartz/dartz.dart';
import 'package:fidelin_user_app/app/modules/auth/data/dto/create_user_dto.dart';
import 'package:fidelin_user_app/app/modules/auth/domain/usecases/signup_with_email_usercase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'signup_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  late SignUpWithEmailUseCase _signUpWithEmailUseCase;

  // final UserStore _userStore = Modular.get<UserStore>();

  _SignUpControllerBase({
    required SignUpWithEmailUseCase signUpWithEmailUseCase,
  }) {
    _signUpWithEmailUseCase = signUpWithEmailUseCase;
  }

  final formField = GlobalKey<FormState>();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @observable
  bool isLoading = false;

  @action
  Future<void> signUp() async {
    isLoading = true;
    if (formField.currentState!.validate()) {
      CreateUserDTO user = CreateUserDTO(
        name: nameTextController.text,
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      final Either<Exception, Unit> response =
          await _signUpWithEmailUseCase.call(user);
      response.fold((Exception e) {}, (_) {
        Modular.to.pop();
      });
    }

    // final Either<Exception, UserEntity> _response =
    //     await _signInWithEmailUseCase.call(
    //   email: emailTextController.text,
    //   password: passwordTextController.text,
    // );
    // _response.fold((Exception e) {}, (UserEntity user) {
    //   _userStore.setUser(user);
    //   Modular.to.navigate('/home/');
    // });

    isLoading = false;
  }

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
}
