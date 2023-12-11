import 'package:white_tiger_shop/common/controller/base_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

class DetailedProductApi extends BaseApi {
  Future<Product> getDetailedProduct(int productId) async {
    final resp = (await makeApiCall(
      'api/common/product/details',
      {'productId': '$productId'},
    ))
        .data;
    return Product.fromJson(resp);
  }
}
