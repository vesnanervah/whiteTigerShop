import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/widgets/detailed_product_view.dart';

class DetailedProductPage extends StatefulWidget {
  final Product product;
  const DetailedProductPage(this.product, {super.key});

  @override
  State<DetailedProductPage> createState() => _DetaieldProductPageState();
}

class _DetaieldProductPageState extends State<DetailedProductPage> {
  final model = ProductsModel();
  @override
  Widget build(BuildContext context) {
    model.fetchDetailedProduct(widget.product.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.black12,
      ),
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
