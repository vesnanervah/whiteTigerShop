import 'package:white_tiger_shop/core/controller/entity/base_response.dart';

class MetaWithUnsuccesException implements Exception {
  String errorMsg;
  BaseResp? resp;
  MetaWithUnsuccesException(this.errorMsg, {this.resp});
}
