import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/core/controller/base_wt_api.dart';

class CategoriesApi extends BaseWTApi {
  Future<List<Category>> getCategories() async {
    final resp = await makeGetRequest('api/common/category/list', null);
    final rawCats = resp.data['categories'] as List;
    final categories = rawCats.map((cat) => Category.fromJson(cat)).toList();
    return categories;
  }
}
