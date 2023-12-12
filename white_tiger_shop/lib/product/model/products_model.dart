import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;
  int currentOffset = 0;
  bool isReachedEnd = false;

  Future<void> fetchProducts(int categoryId, {int? sortType}) async {
    log('fetching the prods with offset $currentOffset');
    if (isReachedEnd) return;
    final resp =
        await api.getProducts(categoryId, currentOffset, sortType: sortType);
    if (currentOffset > 0 && _products != null) {
      _products!.addAll(resp);
    } else {
      _products = resp;
    }
    isReachedEnd = resp.isEmpty || resp.length < 15 ? true : false;
    // вопреки документации, офсет возвращает слайс массива продуктов длинной 15 или менее элементов начиная от переданного индекса
    currentOffset = _products!.length;
    notifyListeners();
  }

  void resetOffset() {
    currentOffset = 0;
  }
}
