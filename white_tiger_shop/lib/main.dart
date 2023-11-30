import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';
import 'package:white_tiger_shop/models/products_model.dart';

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
  final CategoriesModel model = CategoriesModel();
  final CategoriesApi controller = CategoriesApi();
  CategoryGridPage({super.key});
  @override
  Widget build(BuildContext context) {
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
      ),
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
                  .map((prod) => ProductsItemView(prod, category))
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
    return Material(
      color: Colors.deepPurple,
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
  final Category category;
  const ProductsItemView(this.product, this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailedProductPage(product, category)),
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
  final Product product;
  final Category category;
  final ProductsApi controller = ProductsApi();
  final ProductsModel model = ProductsModel();
  DetailedProductPage(this.product, this.category, {super.key});
  @override
  Widget build(BuildContext context) {
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
  final Product product;
  final Category
      category; // В респонсе с сервера нет поля категории, приходится пробрасывать в конструктор
  const DetailedProductView(this.product, this.category, {super.key});
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
