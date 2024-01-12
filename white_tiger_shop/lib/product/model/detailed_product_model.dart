import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entities/product.dart';
import 'package:white_tiger_shop/product/model/entities/review.dart';
import 'package:white_tiger_shop/product/model/reviews_model.dart';

class DetailedProductModel extends BaseModel {
  final _api = ProductsApi();
  late final reviewsModel = ReviewsModel(productId);
  int productId;
  Product? product;
  List<Review>? get reviews => reviewsModel.reviews;

  DetailedProductModel(this.productId);

  @override
  Future<void> fetch() async {
    product = await _api.getDetailedProduct(productId);
    await reviewsModel.update();
  }

  Future<void> leaveReview(String content) async {
    if (isLoading) return;
    isLoading = true;
    await reviewsModel.leaveReview(content);
    isLoading = false;
    notifyListeners();
  }
}
