import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/common/view/networked_image.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class DetailedProductView extends StatelessWidget {
  final Product product;
  const DetailedProductView(this.product, {super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Center(
      child: Card(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [NetworkedImage(180, 180, product.imageUrl)],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Text(product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    height: 1,
                  )),
              const Padding(padding: EdgeInsets.all(4)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Цена: ${product.price}',
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                  Text('Категория: ${product.category ?? 'Не предоставлено'}',
                      style: const TextStyle(fontSize: 16, height: 1.4)),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Text(
                      'Описание: ${product.productDescription != null && product.productDescription!.isNotEmpty ? product.productDescription! : 'Не предоставлено'}',
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListenableBuilder(
                      listenable: state.cart,
                      builder: (_, widget) {
                        return ElevatedButton(
                          // add styles according to cart changes
                          onPressed: () {
                            if (state.cart.inCart(product)) {
                              state.cart.removeFromCart(product);
                            } else {
                              state.cart.addToCart(product);
                            }
                          },
                          child: state.cart.inCart(product)
                              ? const Text('В корзине')
                              : const Text('В корзину'),
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
