class Category {
  int categoryId;
  String title;
  String imageUrl;
  Category(this.categoryId, this.title, this.imageUrl);
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['categoryId'], json['title'], json['imageUrl']);
  }
}
