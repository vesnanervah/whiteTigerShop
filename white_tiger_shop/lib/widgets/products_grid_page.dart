import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/types/category.dart';
import 'package:white_tiger_shop/types/product.dart';
import 'package:white_tiger_shop/widgets/detailed_product_page.dart';
import 'package:white_tiger_shop/widgets/products_list_item.dart';
import 'package:white_tiger_shop/widgets/sort_toggle_btn.dart';
import 'package:white_tiger_shop/widgets/wtshop_app_bar.dart';

class ProductsGridPage extends StatefulWidget {
  final Category category;
  const ProductsGridPage(this.category, {super.key});

  @override
  State<ProductsGridPage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsGridPage> {
  final model = ProductsModel();
  List<Product>? products;
  List<bool> sortOptions = [false, false];
  @override
  Widget build(BuildContext context) {
    //ToggleButtons оперирует индексом элемента из листа sortOptions, поэтому прокидываю его сразу в лист методов сортировок
    List<Function> sortMethods = [
      model.getSortedByName,
      model.getSortedByPrice,
    ];
    if (model.products == null) model.fetchProducts(widget.category.categoryId);
    return Scaffold(
      appBar: WtShopAppBar(widget.category.title),
      body: Container(
        color: Colors.black12,
        child: ListenableBuilder(
          listenable: model,
          builder: (BuildContext context, Widget? child) {
            if (model.products != null && products == null) {
              products = model.products!
                  .toList(); // значения копируются для имутабельности, чтобы всегда можно было откатиться к оригиналу
            }
            return products == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 15),
                        child: ToggleButtons(
                          isSelected: sortOptions,
                          onPressed: (index) {
                            setState(() {
                              if (!sortOptions[index]) {
                                products = sortMethods[index]();
                              } else {
                                products = model.products!.toList();
                              }
                              for (var i = 0; i < sortOptions.length; i++) {
                                if (i == index) {
                                  sortOptions[i] = !sortOptions[i];
                                } else {
                                  sortOptions[i] = false;
                                }
                              }
                            });
                          },
                          children: const [
                            SortToggleBtn('По названию', Icons.title),
                            SortToggleBtn('По цене', Icons.price_change),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => ProductsItemView(
                                  products![index],
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailedProductPage(products![index]),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const Divider(height: 10),
                            itemCount: model.products!.length),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
