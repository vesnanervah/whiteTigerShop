import 'dart:convert';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'dart:developer';

class CategoriesModel {
  List<Category>? categories;
  CategoriesApi api = CategoriesApi();

  fetchCategories() async {
    final resp = await api.getCategories();
    log('fetching ebenya');
    final rawCats = (jsonDecode(resp.body)['data']['categories'] as List);
    categories = rawCats
        .map((cat) => Category(
            cat['categoryId'],
            (cat['title'] as String).trim(),
            (cat['imageUrl'] as String).trim(),
            cat['hasSubcategories'],
            (cat['fullName'] as String).trim(),
            cat['categoryDescription']))
        .toSet()
        .toList(); //хыыы хотел сделать фильтер на повторяющиеся названия категорий, а встроенных методов фильтрации нет в дарте
    for (var cat in categories!) {
      var msg = 'The id is ${cat.categoryId}, the title is ${cat.title};\n';
      log(msg);
    }
  }
}

class Category {
  int categoryId;
  String title;
  String imageUrl;
  int hasSubcategories;
  String fullName;
  String? categoryDescription;
  Category(this.categoryId, this.title, this.imageUrl, this.hasSubcategories,
      this.fullName, this.categoryDescription);
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        json['categoryId'],
        json['title'],
        json['imageUrl'],
        json['hasSubcategories'],
        json['fullname'],
        json['categoryDescription']);
  }
}
