import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/profile/controller/profile_api.dart';
import 'package:white_tiger_shop/profile/model/entities/user.dart';

class ProfileModel extends BaseModel {
  String? token;
  String? email;
  User? user;
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
      if (resp != null) {
        email = savedEmail;
        token = savedToken;
        user = resp.user;
      }
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
    final data = await api.confirmCode(email!, code);
    if (data != null) {
      token = data.token;
      mailSend = false;
      user = data.user;
      saveCreditsToLocal();
    } else {}
    notifyListeners();
    isLoading = false;
    return data != null;
  }

  void saveCreditsToLocal() async {
    await profileBox!.put('email', email);
    await profileBox!.put('token', token);
  }

  void logout() async {
    await profileBox!.clear();
    email = null;
    token = null;
    user = null;
    notifyListeners();
  }

  Future<bool> changeUserName(String newName) async {
    isLoading = true;
    final resp = await api.changeUserName(user!.email, token!, newName);
    if (resp) user!.name = newName;
    isLoading = false;
    return resp;
  }
}
