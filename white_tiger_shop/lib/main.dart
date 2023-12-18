import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/cart/model/cart_model.dart';
import 'package:white_tiger_shop/category/category_grid_page.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dbLoad = Hive.initFlutter();
    return FutureBuilder(
      future: dbLoad,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Provider(
            create: (context) => AppState(),
            child: const MaterialApp(
              title: 'WT Shop',
              home: CategoryGridPage(),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class AppState {
  final CartModel cart = CartModel();
  final ProfileModel profile = ProfileModel();
}
