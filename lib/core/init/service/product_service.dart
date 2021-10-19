import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:vexana/vexana.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/core/init/model/category_model.dart';
import 'package:shop_app/core/init/model/product_model.dart';

class ProductService {
  Dio? dio;

  ProductService() {
    dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080/api"));
  }

  Future<List<Product>?> getAllProducts() async {
    final response = await dio!.get("/products/getall");

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data;

      final validMap =
          json.decode(json.encode(responseBody)) as Map<String, dynamic>;

      return List.generate(validMap['data'].length,
          (index) => Product.fromJson(validMap['data'][index]));
    }
    throw Exception();
  }

  Future<List<Product>?> getAllProductsByCategoryId(int categoryId) async {
    final response =
        await dio!.get("/products/getByCategoryId?categoryId=$categoryId");

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data;

      final validMap =
          json.decode(json.encode(responseBody)) as Map<String, dynamic>;

      return List.generate(validMap['data'].length,
          (index) => Product.fromJson(validMap['data'][index]));
    }
    throw Exception();
  }

  Future<List<Category>?> getAllCategories() async {
    final response = await dio!.get("/categories/getall");

    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data;

      final validMap =
          json.decode(json.encode(responseBody)) as Map<String, dynamic>;

      return List.generate(validMap['data'].length,
          (index) => Category.fromJson(validMap['data'][index]));
    }
    throw Exception();
  }
}
