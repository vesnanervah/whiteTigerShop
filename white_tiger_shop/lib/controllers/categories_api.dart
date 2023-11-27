import 'package:white_tiger_shop/controllers/base_api.dart';

class CategoriesApi extends BaseApi {
  getCategories() {
    return makeApiCall('api/common/category/list', null);
  }
}
