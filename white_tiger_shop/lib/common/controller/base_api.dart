import 'dart:convert';
import 'package:white_tiger_shop/common/controller/entity/base_response.dart';
import 'package:http/http.dart' as http;
import 'package:white_tiger_shop/common/controller/entity/meta_with_unsuccess_exception.dart';

class BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  // TODO: переименовать в host
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
    final BaseResp parsed = BaseResp.fromJson(respBody);
    if (!parsed.meta.success) {
      throw MetaWithUnsuccessException(parsed.meta.error);
    }
    return parsed;
  }

  void filterQuery(Map<String, String?> query) {
    query.removeWhere((key, value) => value == null);
  }
}
