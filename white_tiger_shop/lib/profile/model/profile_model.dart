import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/profile/controller/profile_api.dart';

class ProfileModel extends BaseModel {
  bool? isLogedIn;
  String? token;
  String? email;
  bool mailSend = false;
  String? smsCode;
  Box? profileBox;
  final ProfileApi api = ProfileApi();

  ProfileModel() {
    update();
  }

  Future<void> checkSavedToken() async {
    if (profileBox != null) return;
    profileBox = await Hive.openBox('profile');
    String? savedToken = profileBox!.get('token');
    String? savedEmail = profileBox!.get('email');
    if (savedToken != null && savedEmail != null) {
      final resp = await api.loginByToken(savedEmail, savedToken);
      isLogedIn = resp != null;
      if (isLogedIn!) {
        email = savedEmail;
        token = savedToken;
      }
    } else {
      isLogedIn = false;
    }
  }

  Future<void> requestMail(String enteredEmail) async {
    if (isLoading) return;
    isLoading = true;
    mailSend = await api.initAuth(enteredEmail);
    email = enteredEmail;
    isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> fetch() async {
    await checkSavedToken();
  }

  Future<bool?> sumbitAuth(String code) async {
    if (isLoading) return null;
    isLoading = true;
    final resp = await api.confirmCode(email!, code);
    if (resp != null) {
      token = resp.token;
      isLogedIn = true;
      mailSend = false;
      saveCreditsToLocal();
    } else {}
    notifyListeners();
    isLoading = false;
    return resp != null;
  }

  void saveCreditsToLocal() async {
    await profileBox!.put('email', email);
    await profileBox!.put('token', token);
  }

  void logout() async {
    await profileBox!.clear();
    email = null;
    token = null;
    isLogedIn = false;
    notifyListeners();
  }
}
