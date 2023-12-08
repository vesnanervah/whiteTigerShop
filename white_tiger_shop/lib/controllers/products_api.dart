import 'package:white_tiger_shop/controllers/base_api.dart';
import 'package:white_tiger_shop/types/types.dart';

class ProductsApi extends BaseApi {
  Future<ProductsInnerRespData> getProducts(int categoryId) async {
    return (await makeApiCall(
            'api/common/product/list', {'categoryId': '$categoryId'}))
        .data;
  }

  Future<DetailedProductInnerRespData> getDetailedProduct(int productId) async {
    return (await makeApiCall(
            'api/common/product/details', {'productId': '$productId'}))
        .data;
  }
}
