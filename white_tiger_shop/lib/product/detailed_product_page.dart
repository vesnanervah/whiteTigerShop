import 'package:flutter/material.dart';
import 'package:white_tiger_shop/common/view/wtshop_app_bar.dart';
import 'package:white_tiger_shop/product/model/detailed_product_model.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/view/detailed_product_view.dart';

class DetailedProductPage extends StatefulWidget {
  final Product product;

  const DetailedProductPage(this.product, {super.key});

  @override
  State<DetailedProductPage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState extends State<DetailedProductPage> {
  final model = DetailedProductModel();

  @override
  void initState() {
    super.initState();
    model.fetchDetailedProduct(widget.product.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WtShopAppBar(widget.product.title),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (context, widget) {
            return model.product == null
                ? const Center(child: CircularProgressIndicator())
                : DetailedProductView(model.product!);
          },
        ),
      ),
    );
  }
}
