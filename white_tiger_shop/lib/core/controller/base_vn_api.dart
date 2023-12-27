import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:white_tiger_shop/core/controller/base_api.dart';
import 'package:white_tiger_shop/core/controller/entity/base_response.dart';

class BaseVNApi extends BaseApi {
  // эндпоинты для аутентификации, отзывов и тд на дефолтном сервере оказались не рабочими
  // поэтому написал свой. Если долго грузит, то значит сервак был в спящем режиме и просыпается, нужно подождать + перезапустить приложуху
  // исходники сервера https://github.com/vesnanervah/whiteTigerShopBack
  // респонсы сделал в стиле оригинальных
  final String host = 'whitetigershopback.onrender.com';

  Future<BaseResp> makePostRequest(
      String apiPath, Map<String, dynamic> body) async {
    return makeApiCall(() async {
      final uri = Uri(
        scheme: 'https',
        host: host,
        path: apiPath,
      );
      return http.Client().post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
    });
  }

  Future<BaseResp> makeGetRequest(String apiPath, String query) async {
    final uri = Uri(
      scheme: 'https',
      host: host,
      path: apiPath,
      query: query,
    );
    return makeApiCall(() => http.get(uri));
  }
}
