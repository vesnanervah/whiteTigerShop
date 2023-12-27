import 'package:white_tiger_shop/core/controller/base_wt_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsApi extends BaseWTApi {
  Future<List<Product>> getProducts(int categoryId, int offset,
      {int? sortType}) async {
    final query = {
      'categoryId': '$categoryId',
      'offset': offset.toString(),
      if (sortType != null) 'sortType': '$sortType',
    };
    final resp = await makeGetRequest('api/common/product/list', query);
    final products =
        (resp.data as List).map((prod) => Product.fromJson(prod)).toList();
    return products;
  }

  Future<Product> getDetailedProduct(int productId) async {
    final resp = (await makeGetRequest(
      'api/common/product/details',
      {'productId': '$productId'},
    ))
        .data;
    return Product.fromJson(resp);
  }
}
