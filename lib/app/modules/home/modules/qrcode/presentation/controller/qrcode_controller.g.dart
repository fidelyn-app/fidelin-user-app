// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcode_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QrCodeController on _QrCodeControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_QrCodeControllerBase.isLoading', context: context);

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

  late final _$addPointAsyncAction =
      AsyncAction('_QrCodeControllerBase.addPoint', context: context);

  @override
  Future<void> addPoint(String id) {
    return _$addPointAsyncAction.run(() => super.addPoint(id));
  }

  late final _$addCardAsyncAction =
      AsyncAction('_QrCodeControllerBase.addCard', context: context);

  @override
  Future<void> addCard(String id) {
    return _$addCardAsyncAction.run(() => super.addCard(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
