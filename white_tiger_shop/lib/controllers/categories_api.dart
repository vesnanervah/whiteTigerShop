import 'package:white_tiger_shop/controllers/base_api.dart';
import 'package:white_tiger_shop/types/types.dart';

class CategoriesApi extends BaseApi {
  Future<CategoriesInnerRespData> getCategories() async {
    return (await makeApiCall('api/common/category/list', null)).data;
  }
}
