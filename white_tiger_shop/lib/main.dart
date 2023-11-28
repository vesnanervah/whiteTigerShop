import 'package:flutter/material.dart';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/models/categories_model.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatelessWidget {
  final categoriesModel = CategoriesModel();
  final categoriesController = CategoriesApi();
  App({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //  TODO: disapear back btn on first screen
          title: const Text('WT Shop'),
          leading: const BackButton(),
        ),
        body: CategoryGridPage(categoriesModel, categoriesController));
  }
}

class CategoryGridPage extends StatelessWidget {
  final CategoriesModel model;
  final CategoriesApi controller;
  const CategoryGridPage(this.model, this.controller, {super.key});
  @override
  Widget build(BuildContext context) {
    final getResp = controller.getCategories();
    return FutureBuilder(
        future: getResp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final gridElems = model
                .parseCategories(snapshot.data)
                .map((cat) => CategoryItemView(cat))
                .toList();
            return GridView.count(
              crossAxisCount: 4,
              children: gridElems,
            );
          } else if (snapshot.hasError) {
            return const Text('Error while fetching data');
          }
          return const CircularProgressIndicator();
        });
  }
}

class CategoryItemView extends StatelessWidget {
  final Category category;
  const CategoryItemView(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(category.title),
          Image.network(
            category.imageUrl,
            errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) =>
                const Text('Could not find the image'),
          ),
        ],
      ),
    );
  }
}
