import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/products_model.dart';

class CartModel extends ChangeNotifier {
  final Map<int, Product> _products =
      {}; //не юзается сет, потому что одинаковые продукты, но загруженные по разным фьючерам все ещё считаются разными объектами в дарте
  Map<int, Product> get products => _products;

  Map<int, Product> addToCart(Product newProd) {
    if (!_products.keys.contains(newProd.productId)) {
      _products[newProd.productId] = newProd;
      notifyListeners();
    }
    return _products;
  }

  bool inCart(Product prod) {
    return _products.keys.contains(prod.productId);
  }

  int getLen() {
    return _products.length;
  }

  Map<int, Product> removeFromCart(Product prod) {
    if (_products.keys.contains(prod.productId)) {
      _products.removeWhere((key, value) => key == prod.productId);
      notifyListeners();
    }
    return _products;
  }
}
