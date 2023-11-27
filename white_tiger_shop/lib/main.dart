import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return CategoryGridPage();
  }
}

class CategoryGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('Категории');
  }
}
