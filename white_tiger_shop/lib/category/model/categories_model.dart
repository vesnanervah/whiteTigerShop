import 'package:white_tiger_shop/category/controller/categories_api.dart';
import 'package:white_tiger_shop/category/model/entity/category.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';

class CategoriesModel extends BaseModel<List<Category>?> {
  List<Category>? _categories;
  final api = CategoriesApi();

  @override
  Future<void> fetch() async {
    _categories = await api.getCategories();
  }

  @override
  List<Category>? get data => _categories;
}
