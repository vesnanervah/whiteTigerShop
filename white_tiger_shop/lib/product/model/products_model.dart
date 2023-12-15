import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/data/sort_options.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/product/model/entity/sort_option.dart';

class ProductsModel extends BaseModel<List<Product>> {
  final api = ProductsApi();
  List<Product>? _products;
  @override
  List<Product>? get data => _products;
  int _currentOffset = 0;
  int? selectedCategory;
  SortOption? selectedSortOption;
  bool _isReachedEnd = false;
  bool get isReachedEnd => _isReachedEnd;
  bool isLoading = false;
  final SortOptions sortOptions = SortOptions();

  @override
  Future<void> fetch() async {
    isLoading =
        true; //думал вынести в базовый класс, но в остальные модели вписывается не очень
    final resp = await api.getProducts(selectedCategory!, _currentOffset,
        sortType: selectedSortOption?.apiIndex);
    if (_currentOffset > 0 && _products != null) {
      _products!.addAll(resp);
    } else {
      _products = resp;
    }
    _isReachedEnd = resp.isEmpty ? true : false;
    _currentOffset = _products!.length;
    isLoading = false;
  }

  void resetOffset() {
    _currentOffset = 0;
    _isReachedEnd = false;
    update();
  }
}
