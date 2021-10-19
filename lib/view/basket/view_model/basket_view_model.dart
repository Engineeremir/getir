import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_app/core/base/model/base_view_model.dart';
part 'basket_view_model.g.dart';

class BasketViewModel = _BasketViewModelBase with _$BasketViewModel;

abstract class _BasketViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}
}
