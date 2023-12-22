import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/common/data/my_colors.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/common/view/networked_image.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/product/model/detailed_product_model.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class DetailedProductPage extends BasePage {
  final Product product;

  DetailedProductPage(this.product, {super.key}) : super(product.title);

  @override
  State<BasePage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState extends BasePageState {
  _DetailedProductPageState() : super(DetailedProductModel());

  double calculateCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 575) {
      return width - 30;
    } else if (width >= 575 && width < 768) {
      return 360;
    }
    return 440;
  }

  @override
  void onInitCb() {
    (model as DetailedProductModel).productId =
        (widget as DetailedProductPage).product.productId;
    model!.update();
  }

  @override
  Widget builderCb(BuildContext context) {
    final state = context.watch<AppState>();
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Card(
              color: MyColors.secondaryColor,
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: calculateCardWidth(context)),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: NetworkedImage(180, 180, model!.data!.imageUrl)),
                    const SizedBox(height: 15),
                    Text(
                      model!.data!.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Цена: ${model!.data!.price}',
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    Text(
                      'Категория: ${model!.data!.category ?? 'Не предоставлено'}',
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    Text(
                      'Описание: ${model!.data!.productDescription != null && model!.data!.productDescription!.isNotEmpty ? model!.data!.productDescription! : 'Не предоставлено'}',
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ListenableBuilder(
                        listenable: state.cart,
                        builder: (_, widget) {
                          return ElevatedButton(
                            // add styles according to cart changes
                            onPressed: () {
                              if (state.cart.inCart(model!.data!)) {
                                state.cart.removeFromCart(model!.data!);
                              } else {
                                state.cart.addToCart(model!.data!);
                              }
                            },
                            child: state.cart.inCart(model!.data!)
                                ? const Text(
                                    'В корзине',
                                    style: TextStyle(color: Colors.white70),
                                  )
                                : const Text(
                                    'В корзину',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
