import 'package:white_tiger_shop/common/controller/entity/base_response.dart';

class MetaWithUnsuccessException implements Exception {
  String errorMsg;
  BaseResp? resp;
  MetaWithUnsuccessException(this.errorMsg, {this.resp});
}
