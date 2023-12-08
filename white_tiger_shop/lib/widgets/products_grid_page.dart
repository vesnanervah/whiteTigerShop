import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/models/products_model.dart';
import 'package:white_tiger_shop/types/types.dart';
import 'package:white_tiger_shop/widgets/detailed_product_page.dart';
import 'package:white_tiger_shop/widgets/products_list_item.dart';

class ProductsGridPage extends StatefulWidget {
  final Category category;
  const ProductsGridPage(this.category, {super.key});

  @override
  State<ProductsGridPage> createState() => _ProductsGridPageState();
}

class _ProductsGridPageState extends State<ProductsGridPage> {
  final model = ProductsModel();
  List<Product>? products;
  List<bool> selectedBtns = [false, false];
  @override
  Widget build(BuildContext context) {
    List<Function> events = [
      model.getSortedByName,
      model.getSortedByPrice,
    ]; //сомнительное решение
    if (model.products == null) model.fetchProducts(widget.category.categoryId);
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
            if (model.products != null && products == null) {
              products = model.products!.toList();
            }
            return products == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 15),
                        child: ToggleButtons(
                          isSelected: selectedBtns,
                          onPressed: (index) {
                            setState(() {
                              if (!selectedBtns[index]) {
                                products = events[index]();
                                products!.forEach((element) {
                                  log('${element.price}');
                                });
                              } else {
                                products = model.products!.toList();
                              }
                              for (var i = 0; i < selectedBtns.length; i++) {
                                if (i == index) {
                                  selectedBtns[i] = !selectedBtns[i];
                                } else {
                                  selectedBtns[i] = false;
                                }
                              }
                            });
                          },
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 5),
                              width: 140,
                              child: const Row(children: [
                                Icon(Icons.sort_by_alpha),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Text('По названию')
                              ]),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5),
                              width: 140,
                              child: const Row(children: [
                                Icon(Icons.price_change),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Text('По цене')
                              ]),
                            ),
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
