import 'package:white_tiger_shop/category/controller/categories_api.dart';
import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';

class CategoriesModel extends BaseModel {
  List<Category>? categories;
  final api = CategoriesApi();

  @override
  Future<void> fetch() async {
    categories = await api.getCategories();
  }
}
