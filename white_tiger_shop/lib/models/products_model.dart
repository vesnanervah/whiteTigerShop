import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;

  Future<void> fetchProducts(int categoryId) async {
    _products = parseProducts(await api.getProducts(categoryId));
    notifyListeners();
  }

  List<Product> parseProducts(dynamic resp) {
    final rawProds = (jsonDecode(resp.body)['data'] as List);
    final products =
        rawProds.map((prod) => Product.fromJson(prod)).toSet().toList();
    return products;
  }

  Product parseProduct(dynamic resp) {
    return Product.fromJson(jsonDecode(resp.body)['data']);
  }
}

class Product {
  int productId;
  String title;
  int price;
  String? imageUrl;
  String? productDescription;
  Product(this.productId, this.title, this.price,
      {this.imageUrl, this.productDescription});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['productId'], json['title'], json['price'],
        productDescription: json['productDescription'],
        imageUrl: json['imageUrl']);
  }
}
