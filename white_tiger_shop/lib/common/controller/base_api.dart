import 'dart:convert';
import 'package:white_tiger_shop/common/controller/entity/base_response.dart';
import 'package:white_tiger_shop/common/controller/entity/meta_of_resp.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  final adress = 'ostest.whitetigersoft.ru';

  Future<BaseResp> makeApiCall(
    String apiPath,
    Map<String, String?>? queryArgs,
  ) async {
    if (queryArgs != null) filterQuery(queryArgs);
    final uri = Uri(
        scheme: 'http',
        host: adress,
        path: apiPath,
        queryParameters: queryArgs != null
            ? {...queryArgs, 'appKey': key}
            : {'appKey': key});
    final respBody = jsonDecode((await http.Client().get(uri)).body);
    final MetaOfResp meta =
        MetaOfResp(respBody['meta']['success'], respBody['meta']['error']);
    final BaseResp parsedResp = BaseResp(meta, respBody['data']);
    return parsedResp;
  }

  void filterQuery(Map<String, String?> query) {
    query.removeWhere((key, value) => value == null);
  }
}
