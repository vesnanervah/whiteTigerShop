import 'package:flutter/material.dart';

class WtShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String header;
  const WtShopAppBar(this.header, {super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(header),
      backgroundColor: Colors.black12,
      actions: [
        IconButton(
            // Stack with icon and number with elements count in cart at the top
            onPressed: () {
              // Navigate to cart
            },
            icon: const Icon(Icons.shopping_cart)),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
