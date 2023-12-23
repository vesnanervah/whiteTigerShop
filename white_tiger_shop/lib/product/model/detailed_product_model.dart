import 'package:white_tiger_shop/common/model/base_model.dart';
import 'package:white_tiger_shop/product/controller/products_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class DetailedProductModel extends BaseModel<Product> {
  final api = ProductsApi();
  int productId;
  Product? _product;
  @override
  Product? get data => _product;

  DetailedProductModel(this.productId);

  @override
  Future<void> fetch() async {
    _product = await api.getDetailedProduct(productId!);
  }
}
