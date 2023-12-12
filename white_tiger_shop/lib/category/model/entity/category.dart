import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int categoryId;
  String title;
  String imageUrl;

  Category(this.categoryId, this.title, this.imageUrl);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
