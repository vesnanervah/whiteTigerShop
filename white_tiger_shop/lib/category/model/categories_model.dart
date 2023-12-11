import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/controller/categories_api.dart';
import 'package:white_tiger_shop/category/model/entity/category.dart';

class CategoriesModel extends ChangeNotifier {
  List<Category>? _categories;
  final api = CategoriesApi();

  Future<void> fetchCategories() async {
    _categories = await api.getCategories();
    notifyListeners();
  }

  List<Category>? get categories => _categories;
}
