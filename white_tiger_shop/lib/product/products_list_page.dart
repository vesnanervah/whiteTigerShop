import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/common/view/wtshop_app_bar.dart';
import 'package:white_tiger_shop/product/model/products_model.dart';
import 'package:white_tiger_shop/product/detailed_product_page.dart';
import 'package:white_tiger_shop/product/view/products_list_item.dart';

class ProductsListPage extends StatefulWidget {
  final Category category;

  const ProductsListPage(this.category, {super.key});

  @override
  State<ProductsListPage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsListPage> {
  final model = ProductsModel();
  final TextEditingController sortSelectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    model.fetchProducts(widget.category.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WtShopAppBar(widget.category.title),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (BuildContext context, Widget? child) {
            return model.products == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 10,
                          top: 15,
                        ),
                        child: DropdownMenu(
                          label: const Text('Сортировать'),
                          controller: sortSelectionController,
                          initialSelection: model.sortOptions.options[0],
                          onSelected: (option) {
                            model.selectedSortOption = option;
                            model.reset();
                            model.fetchProducts(widget.category.categoryId);
                          },
                          dropdownMenuEntries:
                              model.sortOptions.options.map((option) {
                            return DropdownMenuEntry(
                                value: option, label: option.title);
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.products!.length + 1,
                          itemBuilder: (_, index) {
                            log('building list with index $index');
                            if (index == model.products!.length &&
                                !model.isReachedEnd) {
                              model.fetchProducts(widget.category.categoryId);
                              return Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (index == model.products!.length &&
                                model.isReachedEnd) {
                              return Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Center(
                                  child: Text(
                                      'Поздравляем! Вы достигли конца списка!'),
                                ),
                              );
                            }
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
          },
        ),
      ),
    );
  }
}
