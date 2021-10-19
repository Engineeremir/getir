import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_app/core/init/model/product_model.dart';
import 'package:shop_app/core/init/service/product_service.dart';

class User extends ChangeNotifier {
  Map<Product, int> basketProducts = {};

  ProductService? service;

  User(BuildContext context) {
    service = context.read<ProductService>();
  }

  List<Product> get basketItems => basketProducts.keys.toList();

  double get getBasketTotalMoney {
    if (basketProducts.isEmpty) {
      return 0;
    } else {
      double total = 0;
      basketProducts.forEach((key, value) {
        total = total + (key.unitPrice! * value);
      });
      return total;
    }
  }

  int get totalProducts {
    return basketProducts.length;
  }

  void addFirstItemToBasket(Product product) {
    basketProducts[product] = 1;
    notifyListeners();
  }

  void incrementProduct(Product product) {
    if (basketProducts[product] == null) {
      addFirstItemToBasket(product);
      return;
    } else {
      basketProducts[product] = basketProducts[product]! + 1;
    }
    notifyListeners();
  }

  void increaseProduct(Product product) {
    if (basketProducts[product] == null) {
      return;
    } else if (basketProducts[product] == 0) {
      basketProducts.removeWhere((key, value) => key == product);
    } else {
      basketProducts[product] = basketProducts[product]! - 1;
    }
    notifyListeners();
  }
}
