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
        body: Container(
            child: CategoryGridPage(categoriesModel, categoriesController)));
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
              crossAxisCount: 5,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              padding: const EdgeInsets.all(25),
              children: gridElems,
            );
          } else if (snapshot.hasError) {
            return const Text('Error while fetching data');
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class CategoryItemView extends StatelessWidget {
  final Category category;
  const CategoryItemView(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber,
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: Colors.black26,
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Expanded(
              child: Image.network(
                fit: BoxFit.cover,
                category.imageUrl,
                errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) =>
                    const Center(
                  child: Text(
                    'Could not find the image',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Text(category.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                )),
          ]),
        ),
      ),
    );
  }
}
