import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class CartModel extends BaseModel {
  Map<int, Product> products = {};

  Box? cartBox;

  CartModel() {
    update();
  }

  void updateLocalCart() async {
    await cartBox!.put('cart', products);
  }

  Map<int, Product> addToCart(Product newProd) {
    if (!products.keys.contains(newProd.productId)) {
      products[newProd.productId] = newProd;
      updateLocalCart();
      notifyListeners();
    }
    return products;
  }

  bool inCart(Product prod) {
    return products.keys.contains(prod.productId);
  }

  int getLen() {
    return products.length;
  }

  void clearCart() {
    products = {};
    updateLocalCart();
    notifyListeners();
  }

  Map<int, Product> removeFromCart(Product prod) {
    if (products.keys.contains(prod.productId)) {
      products.removeWhere((key, value) => key == prod.productId);
      updateLocalCart();
      notifyListeners();
    }
    return products;
  }

  @override
  Future<void> fetch() async {
    if (cartBox != null) return;
    Hive.registerAdapter<Product>(ProductAdapter());
    cartBox = await Hive.openBox('cartBox');
    final saved = cartBox!.get('cart');
    if (saved != null) {
      products = Map<int, Product>.from(saved);
    }
  }
}
