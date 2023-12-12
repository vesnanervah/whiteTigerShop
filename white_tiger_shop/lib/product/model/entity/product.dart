import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int productId;
  @HiveField(1)
  String title;
  @HiveField(2)
  int price;
  @HiveField(3)
  String? imageUrl;
  @HiveField(4)
  String? productDescription;
  @HiveField(5)
  String? category;

  Product(this.productId, this.title, this.price,
      {this.imageUrl, this.productDescription, this.category});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
