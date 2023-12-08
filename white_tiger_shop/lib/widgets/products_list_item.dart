import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/widgets/networked_image.dart';

class ProductsItemView extends StatelessWidget {
  final Product product;
  final VoidCallback onClick;
  const ProductsItemView(this.product, this.onClick, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onClick(),
      leading: NetworkedImage(100, 100, product.imageUrl),
      title: Text(product.title),
      subtitle: Text('Цена: ${product.price}'),
    );
  }
}
