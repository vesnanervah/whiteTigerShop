import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/common/controller/base_api.dart';

class CategoriesApi extends BaseApi {
  Future<List<Category>> getCategories() async {
    final resp = (await makeApiCall('api/common/category/list', null)).data;
    return parseCategories(resp);
  }

  List<Category> parseCategories(Map<String, dynamic> resp) {
    final rawCats = (resp['categories'] as List);
    final categories =
        rawCats.map((cat) => Category.fromJson(cat)).toSet().toList();
    return categories;
  }
}
