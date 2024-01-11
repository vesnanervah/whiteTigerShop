import 'package:white_tiger_shop/core/controller/base_vn_api.dart';
import 'package:white_tiger_shop/core/controller/entity/meta_with_unsuccess_exception.dart';
import 'package:white_tiger_shop/profile/controller/entities/success_login_data.dart';

class ProfileApi extends BaseVNApi {
  Future<bool> initAuth(String email) async {
    final resp = await makePostRequest(
      'init-email-confirm',
      {'email': email},
    );
    return resp.meta.success;
  }

  Future<SuccessLoginData?> confirmCode(String email, String code) async {
    try {
      final resp = await makePostRequest(
        'confirm-email-by-code',
        {'email': email, 'code': code},
      );
      return SuccessLoginData.fromJson(resp.data);
    } on MetaWithUnsuccesException catch (_) {
      return null;
    }
  }

  Future<SuccessLoginData?> loginByToken(String email, String token) async {
    try {
      final resp = await makePostRequest(
        'login-by-token',
        {
          'email': email,
          'token': token,
        },
      );
      return SuccessLoginData.fromJson(resp.data);
    } on MetaWithUnsuccesException catch (_) {
      return null;
    }
  }

  Future<bool> changeUserName(
      String email, String token, String newName) async {
    try {
      final resp = await makePostRequest(
        'update-name',
        {
          'email': email,
          'token': token,
          'name': newName,
        },
      );
      return resp.meta.success;
    } on MetaWithUnsuccesException catch (_) {
      return false;
    }
  }

  Future<bool> changeUserAdress(
      String email, String token, String newAdress) async {
    try {
      final resp = await makePostRequest(
        'update-adress',
        {
          'email': email,
          'token': token,
          'adress': newAdress,
        },
      );
      return resp.meta.success;
    } on MetaWithUnsuccesException catch (_) {
      return false;
    }
  }
}
