// import 'package:customer/app/modules/auth/domain/entities/user_entity.dart';
// import 'package:customer/app/modules/auth/domain/usecases/signin_with_email_usecase.dart';
// import 'package:customer/shared/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'signin_controller.g.dart';

class SignInController = _SignInControllerBase with _$SignInController;

abstract class _SignInControllerBase with Store {
  // late SignInWithEmailUseCase _signInWithEmailUseCase;

  // final UserStore _userStore = Modular.get<UserStore>();

  // _SignInControllerBase(
  //     {required SignInWithEmailUseCase signInWithEmailUseCase}) {
  //   _signInWithEmailUseCase = signInWithEmailUseCase;
  // }

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

  // @action
  // Future<void> signIn() async {
  //   // formField.currentState!.validate()
  //   if (formField.currentState!.validate()) {
  //     loading = true;

  //     final Either<Exception, UserEntity> _response =
  //         await _signInWithEmailUseCase.call(
  //       email: emailTextController.text,
  //       password: passwordTextController.text,
  //     );
  //     _response.fold((Exception e) {}, (UserEntity user) {
  //       _userStore.setUser(user);
  //       Modular.to.navigate('/home/');
  //     });
  //     loading = false;
  //   }
  // }
}
