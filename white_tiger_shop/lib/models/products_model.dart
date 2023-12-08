import 'package:flutter/material.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';
import 'package:white_tiger_shop/types/types.dart';

class ProductsModel extends ChangeNotifier {
  final api = ProductsApi();
  List<Product>? _products;
  Product? _detailedProduct;
  List<Product>? get products => _products;
  Product? get detailedProduct => _detailedProduct;

  Future<void> fetchProducts(int categoryId) async {
    _products = parseProducts(await api.getProducts(categoryId));
    notifyListeners();
  }

  Future<void> fetchDetailedProduct(int productId) async {
    _detailedProduct = parseProduct(await api.getDetailedProduct(productId));
    notifyListeners(); // тут задумался о вынесении в ещё одну модель
  }

  List<Product> parseProducts(ProductsInnerRespData resp) {
    final products =
        resp.map((prod) => Product.fromJson(prod)).toSet().toList();
    return products;
  }

  Product parseProduct(DetailedProductInnerRespData resp) {
    return Product.fromJson(resp);
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
