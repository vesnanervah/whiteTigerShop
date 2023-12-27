import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:white_tiger_shop/core/controller/entity/base_response.dart';
import 'package:white_tiger_shop/core/controller/entity/meta_with_unsuccess_exception.dart';

class BaseVNApi {
  final String host = 'whitetigershopback.onrender.com';

  Future<BaseResp> makePostRequest(
      String apiPath, Map<String, String> body) async {
    final uri = Uri(
      scheme: 'https',
      host: host,
      path: apiPath,
    );
    final response = await http.Client().post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    // TODO: refactor in separate class super class method
    final respBody = jsonDecode((response).body);
    final BaseResp parsed = BaseResp.fromJson(respBody);
    if (!parsed.meta.success) {
      throw MetaWithUnsuccesException(parsed.meta.error);
    }
    return parsed;
  }

  Future<BaseResp> makeGetRequest(String apiPath, String query) async {
    final uri = Uri(scheme: 'https', host: host, path: apiPath, query: query);
    final response = await http.get(uri);
    final respBody = jsonDecode((response).body);
    final BaseResp parsed = BaseResp.fromJson(respBody);
    if (!parsed.meta.success) {
      throw MetaWithUnsuccesException(parsed.meta.error);
    }
    return parsed;
  }
}
