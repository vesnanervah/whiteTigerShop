import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int productId;
  String title;
  int price;
  String? imageUrl;
  String? productDescription;
  String? category;

  Product(this.productId, this.title, this.price,
      {this.imageUrl, this.productDescription, this.category});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
