import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;

  Future<void> fetchProducts(int categoryId, {int? sortType}) async {
    _products = await api.getProducts(categoryId, sortType: sortType);
    notifyListeners();
  }
}
