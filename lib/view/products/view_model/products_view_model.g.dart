// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductsViewModel on _ProductsViewModelBase, Store {
  final _$currentIndexAtom = Atom(name: '_ProductsViewModelBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ProductsViewModelBase.isLoading');

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

  final _$getAllProductsByCategoryIdAsyncAction =
      AsyncAction('_ProductsViewModelBase.getAllProductsByCategoryId');

  @override
  Future<void> getAllProductsByCategoryId(int categoryId) {
    return _$getAllProductsByCategoryIdAsyncAction
        .run(() => super.getAllProductsByCategoryId(categoryId));
  }

  final _$_ProductsViewModelBaseActionController =
      ActionController(name: '_ProductsViewModelBase');

  @override
  void changeLoading() {
    final _$actionInfo = _$_ProductsViewModelBaseActionController.startAction(
        name: '_ProductsViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_ProductsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentIndex(int value) {
    final _$actionInfo = _$_ProductsViewModelBaseActionController.startAction(
        name: '_ProductsViewModelBase.changeCurrentIndex');
    try {
      return super.changeCurrentIndex(value);
    } finally {
      _$_ProductsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
isLoading: ${isLoading}
    ''';
  }
}
