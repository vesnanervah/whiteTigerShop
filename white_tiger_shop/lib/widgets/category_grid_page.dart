import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/widgets/category_grid_item.dart';
import 'package:white_tiger_shop/widgets/products_grid_page.dart';
import 'package:white_tiger_shop/widgets/wtshop_app_bar.dart';

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
      appBar: const WtShopAppBar('WT Shop'),
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
                            maxCrossAxisExtent: 300),
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
