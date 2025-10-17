// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_code_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputCodeController on _InputCodeControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_InputCodeControllerBase.isLoading', context: context);

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

  late final _$successAtom =
      Atom(name: '_InputCodeControllerBase.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_InputCodeControllerBase.error', context: context);

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$addPointAsyncAction =
      AsyncAction('_InputCodeControllerBase.addPoint', context: context);

  @override
  Future<void> addPoint({required String shortCodeId}) {
    return _$addPointAsyncAction
        .run(() => super.addPoint(shortCodeId: shortCodeId));
  }

  late final _$addCardAsyncAction =
      AsyncAction('_InputCodeControllerBase.addCard', context: context);

  @override
  Future<void> addCard({required String shortCodeId}) {
    return _$addCardAsyncAction
        .run(() => super.addCard(shortCodeId: shortCodeId));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
success: ${success},
error: ${error}
    ''';
  }
}
