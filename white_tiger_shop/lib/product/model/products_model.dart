import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/sort_option.dart';

class ProductsModel extends BaseModel {
  final api = ProductsApi();
  List<Product>? products;
  int _currentOffset = 0;
  int? selectedCategory;
  SortOption? selectedSortOption;
  bool _isReachedEnd = false;
  bool get isReachedEnd => _isReachedEnd;

  @override
  Future<void> fetch() async {
    final resp = await api.getProducts(selectedCategory!, _currentOffset,
        sortType: selectedSortOption?.apiIndex);
    if (_currentOffset > 0 && products != null) {
      products!.addAll(resp);
    } else {
      products = resp;
    }
    _isReachedEnd = resp.isEmpty ? true : false;
    _currentOffset = products!.length;
  }

  void reloadData() {
    _currentOffset = 0;
    _isReachedEnd = false;
    update();
  }
}
