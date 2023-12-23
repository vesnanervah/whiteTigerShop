import 'package:flutter/material.dart';
import 'package:white_tiger_shop/core/view/networked_image.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsItemView extends StatelessWidget {
  final Product product;
  final VoidCallback onClick;
  final Widget? trailing;

  const ProductsItemView(this.product, this.onClick,
      {this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onClick(),
      leading: NetworkedImage(100, 100, product.imageUrl),
      title: Text(
        product.title,
        style: const TextStyle(color: Colors.white70),
      ),
      subtitle: Text(
        'Цена: ${product.price}',
        style: const TextStyle(color: Colors.white60),
      ),
      trailing: trailing,
    );
  }
}
