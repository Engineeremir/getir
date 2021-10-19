import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/src/provider.dart';
import 'package:shop_app/core/base/model/base_view_model.dart';
import 'package:shop_app/core/init/model/product_model.dart';
import 'package:shop_app/core/init/service/product_service.dart';
import 'package:shop_app/view/basket/view/basket_view.dart';
import 'package:shop_app/view/home/view_model/home_view_model.dart';
part 'products_view_model.g.dart';

class ProductsViewModel = _ProductsViewModelBase with _$ProductsViewModel;

abstract class _ProductsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;

  late ProductService service;

  @override
  void init() {
    service = ProductService();
  }

  List<Product> products = [];

  @observable
  int currentIndex = 0;

  @observable
  bool isLoading = false;

  int categoryId = 0;

  @action
  Future<void> getAllProductsByCategoryId(int categoryId) async {
    changeLoading();
    products = (await service.getAllProductsByCategoryId(categoryId))!;
    changeLoading();
  }

  void toBasetView() {
    Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (context) => BasketView(),
      ),
    );
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
