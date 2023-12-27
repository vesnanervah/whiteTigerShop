import 'dart:developer';

import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/controller/reviews_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/review.dart';

class DetailedProductModel extends BaseModel<Product> {
  final api = ProductsApi();
  final reviewsApi = ReviewsApi();
  int productId;
  Product? _product;
  List<Review>? reviews;
  @override
  Product? get data => _product;

  DetailedProductModel(this.productId);

  @override
  Future<void> fetch() async {
    _product = await api.getDetailedProduct(productId);
    reviews = await reviewsApi.getReviews(productId);
    for (var i = 0; i < reviews!.length; i++) {
      log(reviews![i].content);
    }
  }
}
