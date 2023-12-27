import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/controller/reviews_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/review.dart';

class DetailedProductModel extends BaseModel {
  final api = ProductsApi();
  final reviewsApi = ReviewsApi();
  int productId;
  Product? product;
  List<Review>? reviews;

  DetailedProductModel(this.productId);

  @override
  Future<void> fetch() async {
    product = await api.getDetailedProduct(productId);
    reviews = await reviewsApi.getReviews(productId);
  }

  // TODO: create model
  Future<void> leaveReview(String content) async {
    if (isLoading) return;
    isLoading = true;
    reviews = await reviewsApi.sendReview(productId, content);
    isLoading = false;
    notifyListeners();
  }
}
