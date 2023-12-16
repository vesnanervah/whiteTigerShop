import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/product/detailed_product_page.dart';
import 'package:white_tiger_shop/product/view/products_list_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return BasePage(state.cart, 'Корзина', () {}, () {
      final productsIds = state.cart.data.keys.toList();
      return productsIds.isNotEmpty
          ? Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                ElevatedButton(
                  onPressed: () => state.cart.clearCart(),
                  child: const Text('Очистить корзину'),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      return ProductsItemView(
                        state.cart.data[productsIds[index]]!,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailedProductPage(
                                state.cart.data[productsIds[index]]!,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          tooltip: 'Убрать из корзины',
                          onPressed: () {
                            state.cart.removeFromCart(
                                state.cart.data[productsIds[index]]!);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(height: 10),
                    itemCount: state.cart.getLen(),
                  ),
                )
              ],
            )
          : const Center(child: Text('В корзине ничего нет'));
    });
  }
}
