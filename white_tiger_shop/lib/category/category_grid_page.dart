import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/categories_model.dart';
import 'package:white_tiger_shop/category/view/category_grid_item.dart';
import 'package:white_tiger_shop/common/view/base_page.dart';
import 'package:white_tiger_shop/product/products_list_page.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});

  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  final model = CategoriesModel();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      model,
      'Категории',
      () => model.update(),
      () => model.data == null
          ? const Center(child: CircularProgressIndicator())
          : model.data!.isNotEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: model.data!.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    maxCrossAxisExtent: 300,
                  ),
                  itemBuilder: (
                    BuildContext context,
                    int count,
                  ) =>
                      CategoryItemView(
                    model.data![count],
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsListPage(model.data![count]),
                      ),
                    ),
                  ),
                )
              : const Center(child: Text('Список категорий пуст.')),
    );
  }
}
