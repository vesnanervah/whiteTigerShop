import 'dart:convert';
import 'dart:developer';
import 'package:white_tiger_shop/types/types.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  final adress = 'ostest.whitetigersoft.ru';

  Future<BaseResp> makeApiCall(String apiPath, ApiArgs? queryArgs) async {
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

  void filterQuery(ApiArgs query) {
    query.removeWhere((key, value) => value == null);
  }
}

class BaseResp {
  MetaOfResp meta;
  dynamic data;
  BaseResp(this.meta, this.data);
}

class MetaOfResp {
  bool success;
  String error;
  MetaOfResp(this.success, this.error);
}
