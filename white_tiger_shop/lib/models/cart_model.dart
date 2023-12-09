import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/products_model.dart';

class CartModel extends ChangeNotifier {
  final Set<Product> _products = {};
  get products => _products;

  Set<Product> addToCart(Product newProd) {
    if (!_products.contains(newProd)) {
      _products.add(newProd);
    }
    notifyListeners();
    return _products;
  }

  bool inCart(Product prod) {
    return _products.contains(prod);
  }

  int getLen() {
    return _products.length;
  }

  Set<Product> removeFromCart(Product prod) {
    if (_products.contains(prod)) {
      _products.remove(prod);
    }
    notifyListeners();
    return _products;
  }
}
