import 'dart:convert';

class ProductsModel {
  List<Product> parseProducts(dynamic resp) {
    final rawProds = (jsonDecode(resp.body)['data'] as List);
    final products = rawProds
        .map((prod) => Product(
            prod['productId'] as int,
            prod['title'] as String,
            prod['imageUrl'] as String,
            prod['price'] as int))
        .toSet()
        .toList();
    return products;
  }
}

class Product {
  int productId;
  String title;
  String imageUrl;
  int price;
  String? productDescription;
  Product(this.productId, this.title, this.imageUrl, this.price);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        json['productId'], json['title'], json['imageUrl'], json['price']);
  }
}
