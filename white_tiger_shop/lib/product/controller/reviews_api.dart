import 'package:white_tiger_shop/core/controller/base_vn_api.dart';
import 'package:white_tiger_shop/product/model/entity/review.dart';

class ReviewsApi extends BaseVNApi {
  Future<List<Review>> getReviews(int productID) async {
    final resp = await makeGetRequest('reviews', 'productID=$productID');
    return (resp.data as List).map((e) => Review.fromJson(e)).toList();
  }

  Future<List<Review>> sendReview(int productID, String content) async {
    final resp = await makePostRequest(
        'review', {"productID": productID, "content": content});
    return (resp.data as List).map((e) => Review.fromJson(e)).toList();
  }
}
