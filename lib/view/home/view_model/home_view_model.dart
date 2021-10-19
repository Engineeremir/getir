import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_app/core/base/model/base_view_model.dart';
import 'package:shop_app/core/init/model/category_model.dart';
import 'package:shop_app/core/init/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/init/service/product_service.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  late ProductService service;

  @override
  void init() {
    service = ProductService();
  }

  @observable
  List<Category?> categories = [];

  @observable
  int currentIndex = 0;

  @observable
  bool isLoading = false;

  @action
  Future<void> getAllCategories() async {
    changeLoading();
    categories = (await service.getAllCategories())!;
    changeLoading();
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }
}
