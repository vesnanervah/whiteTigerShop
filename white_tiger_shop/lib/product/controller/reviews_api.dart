import 'package:white_tiger_shop/core/controller/base_vn_api.dart';
import 'package:white_tiger_shop/product/model/entity/review.dart';

class ReviewsApi extends BaseVNApi {
  Future<List<Review>> getReviews(int productID) async {
    final resp = await makeGetRequest('reviews', 'productID=$productID');
    return (resp.data as List).map((e) => Review.fromJson(e)).toList();
  }
}
