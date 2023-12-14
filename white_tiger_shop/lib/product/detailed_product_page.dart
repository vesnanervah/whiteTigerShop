import 'package:flutter/material.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
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
    model.productId = widget.product.productId;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      model,
      widget.product.title,
      () => DetailedProductView(model.data!),
    );
  }
}
