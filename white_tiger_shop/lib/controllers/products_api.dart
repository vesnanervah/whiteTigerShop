import 'dart:developer';
import 'package:white_tiger_shop/controllers/base_api.dart';

class ProductsApi extends BaseApi {
  getProducts(int categoryId) {
    return makeApiCall(
        'api/common/product/list', {'categoryId': '$categoryId'});
  }

  getDetailedProduct(int productId) {
    return makeApiCall(
        'api/common/product/details', {'productId': '$productId'});
  }
}
