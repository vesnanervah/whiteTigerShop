import 'package:white_tiger_shop/common/controller/base_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsApi extends BaseApi {
  Future<List<Product>> getProducts(int categoryId, int offset,
      {int? sortType}) async {
    final query = {
      'categoryId': '$categoryId',
      'offset': offset.toString(),
      if (sortType != null) 'sortType': '$sortType',
    };
    final resp = await makeApiCall('api/common/product/list', query);
    final products =
        (resp.data as List).map((prod) => Product.fromJson(prod)).toList();
    return products;
  }
}
