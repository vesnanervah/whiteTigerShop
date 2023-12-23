import 'package:flutter/material.dart';
import 'package:white_tiger_shop/cart/model/cart_model.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/product/detailed_product_page.dart';
import 'package:white_tiger_shop/product/view/products_list_item.dart';

class CartPage extends BasePage {
  const CartPage({super.key}) : super('Корзина');

  @override
  State<BasePage> createState() => _CartPageState();
}

class _CartPageState extends BasePageState<CartModel> {
  _CartPageState() : super(CartModel());

  @override
  Widget builderCb(BuildContext context) {
    final productsIds = (model).data.keys.toList();
    return productsIds.isNotEmpty
        ? Column(
            children: [
              const Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                onPressed: () => (model).clearCart(),
                child: const Text(
                  'Очистить корзину',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return ProductsItemView(
                      (model).data[productsIds[index]]!,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailedProductPage(
                              (model).data[productsIds[index]]!,
                            ),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white60,
                        tooltip: 'Убрать из корзины',
                        onPressed: () {
                          (model).removeFromCart(
                            (model).data[productsIds[index]]!,
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(height: 10),
                  itemCount: (model).getLen(),
                ),
              )
            ],
          )
        : const Center(child: Text('В корзине ничего нет'));
  }

  @override
  void onInitCb() {}
}
