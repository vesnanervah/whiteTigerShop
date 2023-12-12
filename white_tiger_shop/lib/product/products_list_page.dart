import 'package:flutter/material.dart';
import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/product/view/sort_toggle_button.dart';
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
  List<bool> sortOptions = [false, false];

  @override
  void initState() {
    super.initState();
    model.fetchProducts(widget.category.categoryId);
  }

  void handleSortClick(int index) {
    if (!sortOptions[index]) {
      model.fetchProducts(widget.category.categoryId, sortType: index + 1);
    } else {
      model.fetchProducts(widget.category.categoryId);
    }
    setState(
      () {
        for (var i = 0; i < sortOptions.length; i++) {
          if (i == index) {
            sortOptions[i] = !sortOptions[i];
          } else {
            sortOptions[i] = false;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model.products == null) model.fetchProducts(widget.category.categoryId);
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
                        child: ToggleButtons(
                          //TODO: make dropdown where u can chose sort option and arrows of sort order
                          isSelected: sortOptions,
                          onPressed: (index) {
                            //TODO: some loading indicator after click
                            handleSortClick(index);
                          },
                          children: const [
                            SortToggleButon(
                              'Сначала дешевле',
                              130,
                            ),
                            SortToggleButon(
                              'Сначала дороже',
                              130,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.products!.length,
                          itemBuilder: (_, index) {
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
