import 'dart:convert';

class CategoriesModel {
  List<Category> parseCategories(dynamic resp) {
    final rawCats = (jsonDecode(resp.body)['data']['categories'] as List);
    final categories = rawCats
        .map((cat) => Category(
            cat['categoryId'],
            (cat['title'] as String).trim(),
            (cat['imageUrl'] as String).trim(),
            cat['hasSubcategories'],
            (cat['fullName'] as String).trim(),
            cat['categoryDescription']))
        .toSet()
        .toList(); //хыыы хотел сделать фильтер на повторяющиеся названия категорий, а встроенных методов фильтрации нет в дарте
    return categories;
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
