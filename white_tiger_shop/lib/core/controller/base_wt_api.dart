import 'package:white_tiger_shop/core/controller/base_api.dart';
import 'package:white_tiger_shop/core/controller/entity/base_response.dart';
import 'package:http/http.dart' as http;

class BaseWTApi extends BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  final host = 'ostest.whitetigersoft.ru';

  Future<BaseResp> makeGetRequest(
    String apiPath,
    Map<String, String?>? queryArgs,
  ) async {
    return makeApiCall(() async {
      if (queryArgs != null) filterQuery(queryArgs);
      final uri = Uri(
          scheme: 'http',
          host: host,
          path: apiPath,
          queryParameters: queryArgs != null
              ? {...queryArgs, 'appKey': key}
              : {'appKey': key});
      return http.Client().get(uri);
    });
  }

  void filterQuery(Map<String, String?> query) {
    query.removeWhere((key, value) => value == null);
  }
}
