import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/core/application.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/core/page/base_page.dart';
import 'package:white_tiger_shop/core/view/networked_image.dart';
import 'package:white_tiger_shop/product/model/detailed_product_model.dart';
import 'package:white_tiger_shop/product/model/entities/product.dart';

class DetailedProductPage extends BasePage {
  final Product product;
  final reviewFormKey = GlobalKey<FormState>();

  DetailedProductPage(this.product, {super.key}) : super(product.title);

  @override
  State<DetailedProductPage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState
    extends BasePageState<DetailedProductModel, DetailedProductPage> {
  final reviewFormController = TextEditingController();

  double calculateBodyWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 575) {
      return width - 30;
    } else if (width >= 575 && width < 768) {
      return 360;
    }
    return 440;
  }

  @override
  DetailedProductModel createModel() =>
      DetailedProductModel(widget.product.productId);

  @override
  void onInitCb() {
    model.update();
  }

  @override
  Widget builderCb(BuildContext context) {
    final state = context.watch<AppState>();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: calculateBodyWidth(context)),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Card(
                color: MyColors.secondaryColor,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: NetworkedImage(
                              180, 180, model.product!.imageUrl)),
                      const SizedBox(height: 15),
                      Text(
                        model.product!.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Цена: ${model.product!.price}',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      Text(
                        'Категория: ${model.product!.category ?? 'Не предоставлено'}',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      Text(
                        'Описание: ${model.product!.productDescription != null && model.product!.productDescription!.isNotEmpty ? model.product!.productDescription! : 'Не предоставлено'}',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ListenableBuilder(
                          listenable: state.cart,
                          builder: (_, widget) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (_) => state.cart.inCart(model.product!)
                                        ? MyColors.superAccentColor
                                        : MyColors.accentColor),
                              ),
                              onPressed: () {
                                if (state.cart.inCart(model.product!)) {
                                  state.cart.removeFromCart(model.product!);
                                } else {
                                  state.cart.addToCart(model.product!);
                                }
                              },
                              child: state.cart.inCart(model.product!)
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
                height: 25,
              ),
              Card(
                color: MyColors.secondaryColor,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 15,
                    bottom: 10,
                    left: 15,
                  ),
                  child: Form(
                    key: widget.reviewFormKey,
                    child: Column(
                      children: [
                        const Text('Оставить отзыв'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: reviewFormController,
                          validator: (value) =>
                              value != null && value.length > 2
                                  ? null
                                  : 'Отзыв должен быть не менее 3х символов',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          onPressed: () {
                            if (widget.reviewFormKey.currentState!.validate()) {
                              final content = reviewFormController.value.text;
                              reviewFormController.clear();
                              model.leaveReview(content).then(
                                    (_) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Отзыв успешно дошёл до сервера!'),
                                      ),
                                    ),
                                  );
                            }
                          },
                          child: const Text(
                            'Отправить',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              model.reviews!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                            color: const Color.fromRGBO(29, 38, 125, 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 15,
                                bottom: 10,
                                left: 15,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Отзыв:',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    model.reviews![index].content,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: model.reviews!.length)
                  : const Text('У этого товара пока что нет отзывов.'),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
