import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/reviews_api.dart';
import 'package:white_tiger_shop/product/model/entities/review.dart';

class ReviewsModel extends BaseModel {
  List<Review>? reviews;
  final api = ReviewsApi();
  int productId;

  ReviewsModel(this.productId);

  @override
  Future<void> fetch() async {
    reviews = await api.getReviews(productId);
  }

  Future<List<Review>> leaveReview(String content) async {
    reviews = await api.sendReview(productId, content);
    return reviews!;
  }
}
