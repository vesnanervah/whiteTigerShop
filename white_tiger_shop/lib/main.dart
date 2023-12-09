import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/models/cart_model.dart';
import 'package:white_tiger_shop/widgets/category_grid_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppState(),
      child: const MaterialApp(
        title: 'WT Shop',
        home: CategoryGridPage(),
      ),
    );
  }
}

class AppState {
  final CartModel cart = CartModel();
}
