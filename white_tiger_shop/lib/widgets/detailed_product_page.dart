import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/types/product.dart';
import 'package:white_tiger_shop/widgets/detailed_product_view.dart';
import 'package:white_tiger_shop/widgets/wtshop_app_bar.dart';

class DetailedProductPage extends StatefulWidget {
  final Product product;
  const DetailedProductPage(this.product, {super.key});

  @override
  State<DetailedProductPage> createState() => _DetailedProductPageState();
}

class _DetailedProductPageState extends State<DetailedProductPage> {
  final model = ProductsModel();
  @override
  Widget build(BuildContext context) {
    model.fetchDetailedProduct(widget.product.productId);
    return Scaffold(
      appBar: WtShopAppBar(widget.product.title),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (context, widget) {
            return model.detailedProduct == null
                ? const Center(child: CircularProgressIndicator())
                : DetailedProductView(model.detailedProduct!);
          },
        ),
      ),
    );
  }
}
