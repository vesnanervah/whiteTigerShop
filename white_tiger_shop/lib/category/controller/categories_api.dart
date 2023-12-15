import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/common/controller/base_api.dart';

class CategoriesApi extends BaseApi {
  Future<List<Category>> getCategories() async {
    final resp = await makeApiCall('api/common/category/list', null);
    final rawCats = resp.data['categories'] as List;
    final categories =
        rawCats.map((cat) => Category.fromJson(cat)).toSet().toList();
    return categories;
  }
}
