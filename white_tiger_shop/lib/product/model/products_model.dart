import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/data/sort_options.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/sort_option.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;
  int currentOffset = 0;
  SortOption? selectedSortOption;
  bool isReachedEnd = false;
  final SortOptions sortOptions = SortOptions();

  Future<void> fetchProducts(int categoryId) async {
    log('fetching the prods with offset $currentOffset');
    if (selectedSortOption != null) {
      log('selected sort option is ${selectedSortOption!.apiIndex}');
    }
    if (isReachedEnd) return;
    final resp = await api.getProducts(categoryId, currentOffset,
        sortType: selectedSortOption?.apiIndex);
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

  void reset() {
    currentOffset = 0;
    isReachedEnd = false;
  }
}
