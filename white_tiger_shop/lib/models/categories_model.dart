import 'package:flutter/material.dart';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/types/category.dart';
import 'package:white_tiger_shop/types/types.dart';

class CategoriesModel extends ChangeNotifier {
  List<Category>? _categories;
  final api = CategoriesApi();

  Future<void> fetchCategories() async {
    _categories = parseCategories(await api.getCategories());
    notifyListeners();
  }

  List<Category>? get categories => _categories;

  List<Category> parseCategories(CategoriesInnerRespData resp) {
    final rawCats = (resp['categories'] as List);
    final categories =
        rawCats.map((cat) => Category.fromJson(cat)).toSet().toList();
    return categories;
  }
}
