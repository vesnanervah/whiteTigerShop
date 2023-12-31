import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entities/product.dart';
import 'package:white_tiger_shop/product/model/entities/sort_option.dart';

class ProductsModel extends BaseModel {
  final api = ProductsApi();
  List<Product>? products;
  int _currentOffset = 0;
  int selectedCategory;
  SortOption? selectedSortOption;
  bool _isReachedEnd = false;
  bool get isReachedEnd => _isReachedEnd;

  ProductsModel(this.selectedCategory);

  @override
  Future<void> fetch() async {
    final resp = await api.getProducts(selectedCategory, 0,
        sortType: selectedSortOption?.apiIndex);
    products = resp;
    _isReachedEnd = resp.isEmpty ? true : false;
    _currentOffset = products!.length;
  }

  Future<void> loadNextOffset() async {
    if (isLoading) return;
    isLoading = true;
    final resp = await api.getProducts(selectedCategory, _currentOffset,
        sortType: selectedSortOption?.apiIndex);
    products!.addAll(resp);
    _isReachedEnd = resp.isEmpty ? true : false;
    _currentOffset = products!.length;
    isLoading = false;
    notifyListeners();
  }

  void reloadData() {
    _currentOffset = 0;
    _isReachedEnd = false;
    products = [];
    update();
  }
}
