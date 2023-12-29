import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/entities/category.dart';
import 'package:white_tiger_shop/core/page/base_page.dart';
import 'package:white_tiger_shop/product/model/entities/sort_options.dart';
import 'package:white_tiger_shop/product/model/products_model.dart';
import 'package:white_tiger_shop/product/detailed_product_page.dart';
import 'package:white_tiger_shop/product/view/products_list_item.dart';

class ProductsListPage extends BasePage {
  final Category category;

  ProductsListPage(this.category, {super.key}) : super(category.title);

  @override
  State<BasePage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState
    extends BasePageState<ProductsModel, ProductsListPage> {
  @override
  ProductsModel createModel() => ProductsModel(widget.category.categoryId);

  @override
  Widget builderCb(BuildContext context) => Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 10,
              top: 15,
            ),
            child: DropdownMenu(
              textStyle: const TextStyle(color: Colors.white70),
              label: const Text('Сортировать'),
              initialSelection: SortOptions.options[0],
              onSelected: (option) {
                model.selectedSortOption = option;
                model.reloadData();
              },
              dropdownMenuEntries: SortOptions.options
                  .map(
                    (option) => DropdownMenuEntry(
                      value: option,
                      label: option.title,
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.products!.length + 1,
              itemBuilder: (_, index) {
                if (index == model.products!.length) {
                  // достигли конца списка и крайнего офсета
                  if ((model).isReachedEnd) {
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Center(
                        child: Text(
                          'Поздравляем! Вы достигли конца списка!',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    );
                  }
                  // достигли конца списка, но запас офсета с сервера ещё есть
                  model.update();
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                //конец списка не достигнут, рендерим продукты
                return ProductsItemView(
                  model.products![index],
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailedProductPage(
                        model.products![index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );

  @override
  void onInitCb() {
    model.update();
  }
}
