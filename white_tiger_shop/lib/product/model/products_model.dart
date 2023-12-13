import 'package:flutter/material.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/data/sort_options.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/sort_option.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  List<Product>? get products => _products;
  int _currentOffset = 0;
  int? selectedCategory;
  SortOption? selectedSortOption;
  bool _isReachedEnd = false;
  bool get isReachedEnd => _isReachedEnd;
  final SortOptions sortOptions = SortOptions();

  Future<void> fetchProducts() async {
    final resp = await api.getProducts(selectedCategory!, _currentOffset,
        sortType: selectedSortOption?.apiIndex);
    if (_currentOffset > 0 && _products != null) {
      _products!.addAll(resp);
    } else {
      _products = resp;
    }
    _isReachedEnd = resp.isEmpty ? true : false;
    _currentOffset = _products!.length;
    notifyListeners();
  }

  void resetOffset() {
    _currentOffset = 0;
    _isReachedEnd = false;
  }
}
