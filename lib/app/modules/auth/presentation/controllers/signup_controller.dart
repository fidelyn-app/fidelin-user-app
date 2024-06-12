import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'signup_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  // late SignUpWithEmailUseCase _signUpWithEmailUseCase;
  // late SignInWithEmailUseCase _signInWithEmailUseCase;

  // final UserStore _userStore = Modular.get<UserStore>();

  // _SignUpControllerBase(
  //     {required SignUpWithEmailUseCase signUpWithEmailUseCase,
  //     required SignInWithEmailUseCase signInWithEmailUseCase}) {
  //   _signUpWithEmailUseCase = signUpWithEmailUseCase;
  //   _signInWithEmailUseCase = signInWithEmailUseCase;
  // }

  final formField = GlobalKey<FormState>();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @observable
  bool isLoading = false;

  // @action
  // Future<void> signUp() async {
  //   isLoading = true;
  //   if (formField.currentState!.validate()) {
  //     UserDTO user = UserDTO(
  //         name: nameTextController!.text,
  //         email: emailTextController.text,
  //         phone: '',
  //         gender: '',
  //         password: passwordTextController.text);

  //     final Either<Exception, Unit> response =
  //         await _signUpWithEmailUseCase.call(user);
  //     response.fold((Exception e) {}, (_) {});
  //   }

  //   final Either<Exception, UserEntity> _response =
  //       await _signInWithEmailUseCase.call(
  //     email: emailTextController.text,
  //     password: passwordTextController.text,
  //   );
  //   _response.fold((Exception e) {}, (UserEntity user) {
  //     _userStore.setUser(user);
  //     Modular.to.navigate('/home/');
  //   });

  //   isLoading = false;
  // }

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
