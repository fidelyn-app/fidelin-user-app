// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpController on _SignUpControllerBase, Store {
  late final _$passwordVisibleAtom = Atom(
    name: '_SignUpControllerBase.passwordVisible',
    context: context,
  );

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
    name: '_SignUpControllerBase.confirmPasswordVisible',
    context: context,
  );

  @override
  bool get confirmPasswordVisible {
    _$confirmPasswordVisibleAtom.reportRead();
    return super.confirmPasswordVisible;
  }

  @override
  set confirmPasswordVisible(bool value) {
    _$confirmPasswordVisibleAtom.reportWrite(
      value,
      super.confirmPasswordVisible,
      () {
        super.confirmPasswordVisible = value;
      },
    );
  }

  late final _$isLoadingAtom = Atom(
    name: '_SignUpControllerBase.isLoading',
    context: context,
  );

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

  late final _$signUpAsyncAction = AsyncAction(
    '_SignUpControllerBase.signUp',
    context: context,
  );

  @override
  Future<void> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  late final _$_SignUpControllerBaseActionController = ActionController(
    name: '_SignUpControllerBase',
    context: context,
  );

  @override
  void togglePasswordVisible() {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
      name: '_SignUpControllerBase.togglePasswordVisible',
    );
    try {
      return super.togglePasswordVisible();
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisible() {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
      name: '_SignUpControllerBase.toggleConfirmPasswordVisible',
    );
    try {
      return super.toggleConfirmPasswordVisible();
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
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
