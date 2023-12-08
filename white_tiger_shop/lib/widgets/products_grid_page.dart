import 'package:flutter/material.dart';
import 'package:white_tiger_shop/models/categories_model.dart';
import 'package:white_tiger_shop/models/products_model.dart';
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
