import 'package:white_tiger_shop/common/controller/base_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';

// TODO: можно объединить с ProductApi. Мы обычно методы группируем в один класс АПИ на основе основной сущности с котрой работает АПИ (продукты, каталоги, чаты, заявки, пользователи, авторизация и т.д.)
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
