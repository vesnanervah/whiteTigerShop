import 'dart:convert';

class CategoriesModel {
  List<Category> parseCategories(dynamic resp) {
    final rawCats = (jsonDecode(resp.body)['data']['categories'] as List);
    final categories =
        rawCats.map((cat) => Category.fromJson(cat)).toSet().toList();
    return categories;
  }
}

class Category {
  int categoryId;
  String title;
  String imageUrl;
  Category(this.categoryId, this.title, this.imageUrl);
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['categoryId'], json['title'], json['imageUrl']);
  }
}
