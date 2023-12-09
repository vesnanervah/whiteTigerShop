import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/widgets/products_list_item.dart';
import 'package:white_tiger_shop/widgets/wtshop_app_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: const WtShopAppBar('Корзина'),
      body: ListenableBuilder(
        listenable: state.cart,
        builder: (_, widget) {
          final productsIds = state.cart.products.keys.toList();
          return ListView.separated(
              // widget with delete from cart button
              itemBuilder: (_, index) {
                return ProductsItemView(
                    state.cart.products[productsIds[index]]!, () {
                  // TODO: navigate to detailed page
                });
              },
              separatorBuilder: (_, index) => const Divider(height: 10),
              itemCount: state.cart.getLen());
        },
      ),
    );
  }
}
