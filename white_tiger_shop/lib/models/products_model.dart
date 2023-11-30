import 'dart:convert';
import 'dart:developer';

class ProductsModel {
  List<Product> parseProducts(dynamic resp) {
    final rawProds = (jsonDecode(resp.body)['data'] as List);
    final products =
        rawProds.map((prod) => Product.fromJson(prod)).toSet().toList();
    return products;
  }

  Product parseProduct(dynamic resp) {
    return Product.fromJson(jsonDecode(resp.body)['data']);
  }
}

class Product {
  int productId;
  String title;
  int price;
  String? imageUrl;
  String? productDescription;
  Product(this.productId, this.title, this.price,
      {this.imageUrl, this.productDescription});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['productId'], json['title'], json['price'],
        productDescription: json['productDescription'],
        imageUrl: json['imageUrl']);
  }
}
