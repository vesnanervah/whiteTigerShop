import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';

class ProfileModel extends BaseModel {
  static bool? isLogedIn;
  static String? token;
  static bool smsSend = false;
  static String? smsCode;
  static Box? profileBox;

  @override
  bool? get data => isLogedIn;

  ProfileModel() {
    checkSavedToken();
  }

  Future<void> checkSavedToken() async {
    if (profileBox != null) return;
    profileBox = await Hive.openBox('profile');
    String? savedToken = profileBox!.get('token');
    if (savedToken != null) {
      token = savedToken;
      // получение токена не имплементировано на сервере
    } else {
      isLogedIn = false;
    }
  }

  Future<void> requestSms() async {
    // получение смс не имплементировано на сервере, поэтому эмулирую
    smsSend = true;
    smsCode = await Future.delayed(Durations.short3, () => '1234');
    notifyListeners();
  }

  @override
  Future<void> fetch() {
    // TODO: read access token from local and post to server
    throw UnimplementedError();
  }

  void sumbitAuth(String code) {
    if (smsSend && code == smsCode) {
      isLogedIn = true;
      smsSend = false;
      notifyListeners();
    }
  }
}
