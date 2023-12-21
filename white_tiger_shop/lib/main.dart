import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:white_tiger_shop/cart/model/cart_model.dart';
import 'package:white_tiger_shop/category/category_grid_page.dart';
import 'package:white_tiger_shop/common/data/my_colors.dart';
import 'package:white_tiger_shop/profile/model/profile_model.dart';

// TODO: Структура.
// В больших проектах с множеством экранов и сущностей хранить все классы в рамках нескольких директорий неудобно.
// Что бы проще было ориентироваться, мы разбиваем приложение на модули на основе ключевых объектов или функций.
// Например: чаты, авторизация, каталог, заявки и пр.
// Общие файлы, или файлы используемые во множестве модулей находятся в директории core.
// Внутренняя структура модулей у нас оптимизирована для модулей среднего размера, т.к. они чаще встречаются.
// Для небольших модулей такая структура может показаться избыточной, а для больших недостаточной. Но стараемся придерживаться её.
// Структура модулей делится на:
//    * page - страницы приложения (во всех модулях кроме core находятся в корне модуля)
//    * view - виджеты
//    * model - объединяет все классы для работы с данными: сущности, апи, модели, и пр.
// Если каких-то компонентов в модуле нет- директории для них не нужны.
// Внутри "стандартных" директорий могут быть дополнительные директории в крупных модулях или в core
// Пример структуры внутри lib (категории по аналогии с продуктами):
// lib
// ├ core
// │ ├ model/ (базовые модели приложения, структура аналогична)
// │ ├ view/ (общие виджеты приложения и различные хелперы и миксины для них.)
// │ ├ page/ (базовые классы страниц)
// │ └ application.dart (является одним из ключевых классов приложения, поэтому лежит в корне папки core)
// ├ product
// │ ├ model/
// │ │ ├ api/
// │ │ │ └ product_api.dart
// │ │ ├ entities/
// │ │ │  ├ product.dart
// │ │ │  └ product.g.dart
// │ │ ├ product_list_model.dart
// │ │ └ product_details_model.dart
// │ ├ view/
// │ │ └ product_item_widget.dart
// │ ├ product_list_page.dart
// │ └ product_details_page.dart
// ├ category (по аналогии с продуктами)
// ├ ... other_modules
// └ main.dart

void main() {
  runApp(const App());
}

// TODO вынести в отдельный класс в корне core
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
                  labelSmall: TextStyle(color: Colors.white70),
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
