// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordController on _ForgotPasswordControllerBase, Store {
  late final _$passwordVisibleAtom = Atom(
      name: '_ForgotPasswordControllerBase.passwordVisible', context: context);

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  late final _$confirmPasswordVisibleAtom = Atom(
      name: '_ForgotPasswordControllerBase.confirmPasswordVisible',
      context: context);

  @override
  bool get confirmPasswordVisible {
    _$confirmPasswordVisibleAtom.reportRead();
    return super.confirmPasswordVisible;
  }

  @override
  set confirmPasswordVisible(bool value) {
    _$confirmPasswordVisibleAtom
        .reportWrite(value, super.confirmPasswordVisible, () {
      super.confirmPasswordVisible = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ForgotPasswordControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$requestForgotPasswordAsyncAction = AsyncAction(
      '_ForgotPasswordControllerBase.requestForgotPassword',
      context: context);

  @override
  Future<void> requestForgotPassword() {
    return _$requestForgotPasswordAsyncAction
        .run(() => super.requestForgotPassword());
  }

  late final _$updatePasswordAsyncAction = AsyncAction(
      '_ForgotPasswordControllerBase.updatePassword',
      context: context);

  @override
  Future<void> updatePassword() {
    return _$updatePasswordAsyncAction.run(() => super.updatePassword());
  }

  late final _$_ForgotPasswordControllerBaseActionController =
      ActionController(name: '_ForgotPasswordControllerBase', context: context);

  @override
  void togglePasswordVisible() {
    final _$actionInfo =
        _$_ForgotPasswordControllerBaseActionController.startAction(
            name: '_ForgotPasswordControllerBase.togglePasswordVisible');
    try {
      return super.togglePasswordVisible();
    } finally {
      _$_ForgotPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisible() {
    final _$actionInfo =
        _$_ForgotPasswordControllerBaseActionController.startAction(
            name: '_ForgotPasswordControllerBase.toggleConfirmPasswordVisible');
    try {
      return super.toggleConfirmPasswordVisible();
    } finally {
      _$_ForgotPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_ForgotPasswordControllerBaseActionController
        .startAction(name: '_ForgotPasswordControllerBase.reset');
    try {
      return super.reset();
    } finally {
      _$_ForgotPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
passwordVisible: ${passwordVisible},
confirmPasswordVisible: ${confirmPasswordVisible},
isLoading: ${isLoading}
    ''';
  }
}
