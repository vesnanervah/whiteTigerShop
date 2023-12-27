import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/cart/model/cart_model.dart';
import 'package:white_tiger_shop/category/category_grid_page.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';
import 'package:white_tiger_shop/core/view/my_colors.dart';

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
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: MyColors.accentColor,
                textTheme: const TextTheme(
                  labelLarge: TextStyle(color: Colors.white70),
                  labelMedium: TextStyle(color: Colors.white70),
                  labelSmall: TextStyle(color: Colors.white70, fontSize: 11),
                  bodySmall: TextStyle(color: Colors.white70),
                  bodyMedium: TextStyle(color: Colors.white70),
                  bodyLarge: TextStyle(color: Colors.white70),
                  titleSmall: TextStyle(color: Colors.white60),
                  titleMedium: TextStyle(color: Colors.white60),
                  titleLarge: TextStyle(color: Colors.white70),
                  headlineSmall: TextStyle(color: Colors.white60),
                  headlineMedium: TextStyle(color: Colors.white70),
                  headlineLarge: TextStyle(color: Colors.white70),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => MyColors.accentColor),
                  ),
                ),
              ),
              title: 'WT Shop',
              home: const CategoryGridPage(),
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
