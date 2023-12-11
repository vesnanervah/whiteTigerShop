import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;

  Future<void> fetchProducts(int categoryId) async {
    _products = await api.getProducts(categoryId);
    notifyListeners();
  }

  List<Product> getSortedByName() {
    List<Product> newProducts = products!.toList();
    newProducts.sort((f, s) => f.title.compareTo(s.title));
    return newProducts;
  }

  List<Product> getSortedByPrice() {
    List<Product> newProducts = products!.toList();
    newProducts.sort((f, s) => f.price.compareTo(s.price));
    return newProducts;
  }
}
