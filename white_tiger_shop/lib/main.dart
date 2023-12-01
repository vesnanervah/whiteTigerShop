import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';
import 'package:white_tiger_shop/models/products_model.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MaterialApp(
        title: 'WT Shop',
        home: CategoryGridPage(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  final CategoriesModel categoriesModel = CategoriesModel();
  final CategoriesApi categoriesController = CategoriesApi();
  var categoriesView = const CategoryGridPage();
  final ProductsModel productsModel = ProductsModel();
  final ProductsApi productsController = ProductsApi();
  var productsView = const ProductsGridPage();
  var detailedProductView = const DetailedProductPage();
}

class CategoryGridPage extends StatelessWidget {
  const CategoryGridPage({super.key});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    final CategoriesModel model = state.categoriesModel;
    final CategoriesApi controller = state.categoriesController;
    final getResp = controller.getCategories();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('WT Shop'),
      ),
      body: Container(
        color: Colors.black12,
        child: FutureBuilder(
            future: getResp,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final gridElems = model
                    .parseCategories(snapshot.data)
                    .map((cat) => CategoryItemView(cat))
                    .toList();
                return GridView.count(
                  crossAxisCount:
                      (MediaQuery.of(context).size.width ~/ 300).toInt(),
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
      ),
    );
  }
}

class ProductsGridPage extends StatelessWidget {
  const ProductsGridPage({super.key});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    final controller = state.productsController;
    final model = state.productsModel;
    final Category category = state.categoriesModel.selectedCategory!;
    final productsResp = controller.getProducts(category.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        leading: const BackButton(),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black12,
        child: FutureBuilder(
          future: productsResp,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listElems = model
                  .parseProducts(snapshot.data)
                  .map((prod) => ProductsItemView(prod))
                  .toList();
              return ListView.separated(
                  itemBuilder: (context, index) => listElems[index],
                  separatorBuilder: (context, index) =>
                      const Divider(height: 10),
                  itemCount: listElems.length);
            } else if (snapshot.hasError) {
              return const Text('Could not load products');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class CategoryItemView extends StatelessWidget {
  final Category category;
  const CategoryItemView(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    return Material(
      color: Colors.deepPurple,
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              state.categoriesModel.selectedCategory = category;
              return state.productsView;
            }),
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
    var state = context.watch<AppState>();
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          state.productsModel.selectedProduct = product;
          return state.detailedProductView;
        }),
      ),
      leading: SizedBox(
        width: 100,
        child: product.imageUrl != null
            ? Image.network(
                fit: BoxFit.cover,
                product.imageUrl!,
                errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) =>
                    const Icon(
                  Icons.error,
                  size: 40,
                ),
              )
            : const Center(
                child: Text('Image wasn\'t provided'),
              ),
      ),
      title: Text(product.title),
      subtitle: Text('Цена: ${product.price}'),
    );
  }
}

class DetailedProductPage extends StatelessWidget {
  const DetailedProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    final ProductsApi controller = state.productsController;
    final ProductsModel model = state.productsModel;
    final Product product = model.selectedProduct!;
    final Category category = state.categoriesModel.selectedCategory!;
    final productResp = controller.getDetailedProduct(product.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        leading: const BackButton(),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black12,
        child: FutureBuilder(
            future: productResp,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final resolvedProduct = model.parseProduct(snapshot.data);
                return DetailedProductView(resolvedProduct, category);
              } else if (snapshot.hasError) {
                return const Text('Could not load detailed product');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}

class DetailedProductView extends StatelessWidget {
  Product product;
  Category category;
  DetailedProductView(this.product, this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: product.imageUrl != null
                          ? Image.network(
                              fit: BoxFit.cover,
                              product.imageUrl!,
                              errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) =>
                                  Container(
                                color: Colors.grey,
                                child: const Center(
                                  child: Text(
                                    'Could not find the image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('Image was not uploaded',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic))),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Text(product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      height: 1,
                    )),
                const Padding(padding: EdgeInsets.all(4)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Цена: ${product.price}',
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                    Text('Категория: ${category.title.trim()}',
                        style: const TextStyle(fontSize: 16, height: 1.4)),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Text(
                          'Описание: ${product.productDescription != null && product.productDescription!.isNotEmpty ? product.productDescription! : 'Не предоставлено'}',
                          style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              overflow: TextOverflow.fade)),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
