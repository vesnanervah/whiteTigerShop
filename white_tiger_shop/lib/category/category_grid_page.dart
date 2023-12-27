import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/categories_model.dart';
import 'package:white_tiger_shop/category/view/category_grid_item.dart';
import 'package:white_tiger_shop/core/page/base_page.dart';
import 'package:white_tiger_shop/product/products_list_page.dart';

class CategoryGridPage extends BasePage {
  const CategoryGridPage({super.key}) : super('Категории');

  @override
  State<BasePage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState
    extends BasePageState<CategoriesModel, CategoryGridPage> {
  @override
  CategoriesModel createModel() => CategoriesModel();

  @override
  Widget builderCb(BuildContext context) => model.categories!.isNotEmpty
      ? GridView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          itemCount: model.categories!.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            maxCrossAxisExtent: 380,
          ),
          itemBuilder: (
            BuildContext context,
            int count,
          ) =>
              CategoryItemView(
            model.categories![count],
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductsListPage(model.categories![count]),
              ),
            ),
          ),
        )
      : const Center(child: Text('Список категорий пуст.'));

  @override
  void onInitCb() {
    model.update();
  }
}
