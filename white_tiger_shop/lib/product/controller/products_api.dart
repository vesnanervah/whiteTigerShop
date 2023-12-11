import 'package:white_tiger_shop/common/controller/base_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class ProductsApi extends BaseApi {
  Future<List<Product>> getProducts(int categoryId, {int? sortType}) async {
    final query = {
      'categoryId': '$categoryId',
      if (sortType != null) 'sortType': '$sortType',
    };
    final resp = (await makeApiCall('api/common/product/list', query)).data;
    return parseProducts(resp);
  }

  List<Product> parseProducts(List<dynamic> resp) {
    final products =
        resp.map((prod) => Product.fromJson(prod)).toSet().toList();
    return products;
  }
}
