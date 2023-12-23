import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/cart/cart_page.dart';
import 'package:white_tiger_shop/common/data/my_colors.dart';
import 'package:white_tiger_shop/main.dart';
import 'package:white_tiger_shop/profile/profile_page.dart';

class WtShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String header;

  const WtShopAppBar(this.header, {super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return AppBar(
      title: Text(header),
      titleTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 19,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: Colors.white70),
      backgroundColor: MyColors.secondaryColor,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          ),
          icon: const Icon(Icons.person),
        ),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            ListenableBuilder(
              listenable: state.cart,
              builder: (_, widget) {
                return Container(
                  decoration: const BoxDecoration(
                    color: MyColors.accentColor,
                    shape: BoxShape.circle,
                  ),
                  width: 16,
                  height: 16,
                  child: Center(
                    child: Text(
                      '${state.cart.getLen()}',
                      style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
