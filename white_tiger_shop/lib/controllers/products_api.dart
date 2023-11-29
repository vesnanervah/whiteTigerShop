import 'package:white_tiger_shop/controllers/base_api.dart';

class ProductsApi extends BaseApi {
  getProducts(int categoryId) {
    return makeApiCall(
        'api/common/product/list', {'categoryId': '$categoryId'});
  }
}
