import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/cart/cart_page.dart';
import 'package:white_tiger_shop/cart/model/cart_model.dart';
import 'package:white_tiger_shop/core/application.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';
import 'package:white_tiger_shop/profile/profile_page.dart';

class WtShopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const WtShopAppBar(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  State<WtShopAppBar> createState() => _WtShopAppBarState();
}

class _WtShopAppBarState extends State<WtShopAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final CartModel cart;

  void animationStart() {
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.isCurrent &&
        cart.getLen() > 0) {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 260),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _controller.value == 1) {
        _controller.reverse();
      }
    });
    cart = context.read<AppState>().cart;
    cart.addListener(animationStart);
  }

  @override
  void dispose() {
    _controller.dispose();
    cart.removeListener(animationStart);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return AppBar(
      title: Text(widget.title),
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
                return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) => Transform.scale(
                          scale: 1 + _controller.value,
                          child: child,
                        ),
                    child: Container(
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
                    ));
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
}
