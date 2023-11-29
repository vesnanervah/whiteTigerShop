import 'package:flutter/material.dart';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';
import 'package:white_tiger_shop/models/products_model.dart';

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
    return CategoryGridPage(categoriesModel, categoriesController);
  }
}

class CategoryGridPage extends StatelessWidget {
  final CategoriesModel model;
  final CategoriesApi controller;
  const CategoryGridPage(this.model, this.controller, {super.key});
  @override
  Widget build(BuildContext context) {
    final getResp = controller.getCategories();
    return Scaffold(
      appBar: AppBar(
        title: const Text('WT Shop'),
      ),
      body: FutureBuilder(
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
          }),
    );
  }
}

class ProductsGridPage extends StatelessWidget {
  final Category category;
  final controller = ProductsApi();
  final model = ProductsModel();
  ProductsGridPage(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    final productsResp = controller.getProducts(category.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        leading: const BackButton(),
      ),
      body: FutureBuilder(
        future: productsResp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listElems = model
                .parseProducts(snapshot.data)
                .map((prod) => ProductsItemView(prod))
                .toList();
            return ListView.separated(
                itemBuilder: (context, index) => listElems[index],
                separatorBuilder: (context, index) => const Divider(height: 10),
                itemCount: listElems.length - 1);
          } else if (snapshot.hasError) {
            return const Text('Could not load products');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductsGridPage(category)),
          );
        },
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

class ProductsItemView extends StatelessWidget {
  final Product product;
  const ProductsItemView(this.product, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 200,
        width: 200,
        child: Image.network(
          fit: BoxFit.cover,
          product.imageUrl,
          errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) =>
              const Icon(
            Icons.error,
            size: 40,
          ),
        ),
      ),
      title: Text(product.title),
      subtitle: Text('Цена: ${product.price}'),
    );
  }
}
