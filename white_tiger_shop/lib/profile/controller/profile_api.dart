import 'package:white_tiger_shop/core/controller/base_vn_api.dart';
import 'package:white_tiger_shop/core/controller/entity/meta_with_unsuccess_exception.dart';

class ProfileApi extends BaseVNApi {
  Future<bool> initAuth(String email) async {
    final resp = await makePostRequest(
      'init-email-confirm',
      {'email': email},
    );
    return resp.meta.success;
  }

  Future<(bool status, String? token)> confirmCode(
      String email, String code) async {
    try {
      final resp = await makePostRequest(
        'confirm-email-by-code',
        {'email': email, 'code': code},
      );
      return (resp.meta.success, resp.data as String?);
    } on MetaWithUnsuccesException catch (_) {
      return (false, null);
    }
  }

  Future<bool> loginByToken(String email, String token) async {
    try {
      final resp = await makePostRequest(
        'login-by-token',
        {
          'email': email,
          'token': token,
        },
      );
      return resp.meta.success;
    } on MetaWithUnsuccesException catch (_) {
      return false;
    }
  }
}
