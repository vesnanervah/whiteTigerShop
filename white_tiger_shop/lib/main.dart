import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:white_tiger_shop/controllers/categories_api.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/controllers/products_api.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/widgets/networked_image.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppState(),
      child: const MaterialApp(
        title: 'WT Shop',
        home: CategoryGridPage(),
      ),
    );
  }
}

class AppState {
  final ProductsModel productsModel = ProductsModel();
  final ProductsApi productsController = ProductsApi();
}

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});

  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  final model = CategoriesModel();
  @override
  Widget build(BuildContext context) {
    model.fetchCategories();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text('WT Shop'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (BuildContext context, Widget? child) {
            return model.categories == null
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: model.categories!.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            maxCrossAxisExtent: 250),
                    itemBuilder: (BuildContext context, int count) =>
                        CategoryItemView(
                      model.categories![count],
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductsGridPage(model.categories![count]),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class ProductsGridPage extends StatefulWidget {
  final Category category;
  const ProductsGridPage(this.category, {super.key});

  @override
  State<ProductsGridPage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsGridPage> {
  final model = ProductsModel();
  @override
  Widget build(BuildContext context) {
    model.fetchProducts(widget.category.categoryId);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (BuildContext context, Widget? child) {
            return model.products == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) => ProductsItemView(
                          model.products![index],
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DetailedProductPage(model.products![index]),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 10),
                    itemCount: model.products!.length);
          },
        ),
      ),
    );
  }
}

class CategoryItemView extends StatelessWidget {
  final Category category;
  final VoidCallback onClick;
  const CategoryItemView(this.category, this.onClick, {super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple,
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        splashColor: Colors.black26,
        onTap: () => onClick(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Expanded(child: NetworkedImage(180, 180, category.imageUrl)),
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
  final VoidCallback onClick;
  const ProductsItemView(this.product, this.onClick, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onClick(),
      leading: NetworkedImage(100, 100, product.imageUrl),
      title: Text(product.title),
      subtitle: Text('Цена: ${product.price}'),
    );
  }
}

class DetailedProductPage extends StatefulWidget {
  final Product product;
  const DetailedProductPage(this.product, {super.key});

  @override
  State<DetailedProductPage> createState() => _DetaieldProductPageState();
}

class _DetaieldProductPageState extends State<DetailedProductPage> {
  final model = ProductsModel();
  @override
  Widget build(BuildContext context) {
    model.fetchDetailedProduct(widget.product.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (context, widget) {
            return model.detailedProduct == null
                ? const Center(child: CircularProgressIndicator())
                : DetailedProductView(model.detailedProduct!);
          },
        ),
      ),
    );
  }
}

class DetailedProductView extends StatelessWidget {
  final Product product;
  const DetailedProductView(this.product, {super.key});
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
                children: [NetworkedImage(180, 180, product.imageUrl)],
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
                  const Text('Категория: не имплементировано в api',
                      style: TextStyle(fontSize: 16, height: 1.4)),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: Text(
                      'Описание: ${product.productDescription != null && product.productDescription!.isNotEmpty ? product.productDescription! : 'Не предоставлено'}',
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
