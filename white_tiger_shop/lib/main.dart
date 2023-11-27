import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/categories_model.dart';

void main() {
  final catModel = CategoriesModel();
  catModel.fetchCategories();
  runApp(const MaterialApp(
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text('test');
  }
}
