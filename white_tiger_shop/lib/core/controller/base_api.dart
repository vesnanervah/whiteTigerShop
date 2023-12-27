import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:white_tiger_shop/core/controller/entity/base_response.dart';
import 'package:white_tiger_shop/core/controller/entity/meta_with_unsuccess_exception.dart';

class BaseApi {
  Future<BaseResp> makeApiCall(Future<Response> Function() fetchCb) async {
    final body = jsonDecode((await fetchCb()).body);
    final BaseResp parsed = BaseResp.fromJson(body);
    if (!parsed.meta.success) {
      log(parsed.meta.error);
      throw MetaWithUnsuccesException(parsed.meta.error);
    }
    return parsed;
  }
}
