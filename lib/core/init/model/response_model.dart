import 'product_model.dart';

class SelectModel {
  int? productId;

  Product? products;

  SelectModel({
    required this.productId,
    required this.products,
  });

  factory SelectModel.fromJson(Map<String, dynamic> data) {
    return SelectModel(
      products: data['subItem'],
      productId: data['subItemIndex'],
    );
  }
}
