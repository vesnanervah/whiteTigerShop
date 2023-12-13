import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class CartModel extends ChangeNotifier {
  Map<int, Product> _products = {};
  Map<int, Product> get products => _products;
  Box? cartBox;

  CartModel() {
    initLocalCart();
  }

  Future<void> initLocalCart() async {
    // в дебаге при хотрелоаде может спонтанно(очень редко) ругануться на уже используемый айди типа адаптера
    // возможно ошибка внутри самого пакета, лечится рестартом
    Hive.registerAdapter(ProductAdapter());
    cartBox = await Hive.openBox('cartBox');
    final saved = cartBox!.get('cart');
    if (saved != null) {
      _products = {
        ...saved
      }; // деструктуризация - костыль без которого кидает тайп ерор в ран тайм. Пробовал каст, дженерик и тд, никак не переваривает.
    }
    notifyListeners();
  }

  void updateLocalCart() async {
    await cartBox!.put('cart', _products);
  }

  Map<int, Product> addToCart(Product newProd) {
    if (!_products.keys.contains(newProd.productId)) {
      _products[newProd.productId] = newProd;
      updateLocalCart();
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

  void clearCart() {
    _products = {};
    updateLocalCart();
    notifyListeners();
  }

  Map<int, Product> removeFromCart(Product prod) {
    if (_products.keys.contains(prod.productId)) {
      _products.removeWhere((key, value) => key == prod.productId);
      updateLocalCart();
      notifyListeners();
    }
    return _products;
  }
}
