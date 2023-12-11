import 'dart:developer';
import 'package:white_tiger_shop/common/controller/base_api.dart';
import 'package:white_tiger_shop/product/model/entity/product.dart';
import 'package:white_tiger_shop/types/types.dart';

class ProductsApi extends BaseApi {
  Future<List<Product>> getProducts(int categoryId, {int? sortType}) async {
    final resp = (await makeApiCall('api/common/product/list', {
      'categoryId': '$categoryId',
      if (sortType != null) 'sortType': '$sortType',
    }))
        .data;
    return parseProducts(resp);
  }

  List<Product> parseProducts(ProductsInnerRespData resp) {
    final products =
        resp.map((prod) => Product.fromJson(prod)).toSet().toList();
    return products;
  }
}