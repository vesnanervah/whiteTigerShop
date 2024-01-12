import 'dart:developer';
import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/core/model/base_model.dart';
import 'package:white_tiger_shop/profile/controller/profile_api.dart';
import 'package:white_tiger_shop/profile/model/entities/user.dart';

class ProfileModel extends BaseModel {
  String? _token;
  String? email;
  User? user;
  bool mailSend = false;
  String? smsCode;
  Box? _profileBox;
  final ProfileApi _api = ProfileApi();

  ProfileModel() {
    update();
  }

  Future<void> checkSavedToken() async {
    if (_profileBox != null) return;
    _profileBox = await Hive.openBox('profile');
    String? savedToken = _profileBox!.get('token');
    String? savedEmail = _profileBox!.get('email');
    if (savedToken != null && savedEmail != null) {
      final resp = await _api.loginByToken(savedEmail, savedToken);
      if (resp != null) {
        email = savedEmail;
        _token = savedToken;
        user = resp.user;
      }
    }
    notifyListeners();
  }

  Future<void> requestMail(String enteredEmail) async {
    if (isLoading) return;
    isLoading = true;
    mailSend = await _api.initAuth(enteredEmail);
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
    final data = await _api.confirmCode(email!, code);
    if (data != null) {
      log(data.user.name ?? 'Имя не установлено');
      _token = data.token;
      mailSend = false;
      user = data.user;
      saveCreditsToLocal();
    } else {}
    isLoading = false;
    notifyListeners();
    return data != null;
  }

  void saveCreditsToLocal() async {
    await _profileBox!.put('email', email);
    await _profileBox!.put('token', _token);
  }

  void logout() async {
    await _profileBox!.clear();
    email = null;
    _token = null;
    user = null;
    notifyListeners();
  }

  Future<bool> changeUserName(String newName) async {
    isLoading = true;
    final resp = await _api.changeUserName(user!.email, _token!, newName);
    if (resp) user!.name = newName;
    isLoading = false;
    notifyListeners();
    return resp;
  }

  Future<bool> changeUserAdress(String newAdress) async {
    isLoading = true;
    final resp = await _api.changeUserAdress(user!.email, _token!, newAdress);
    if (resp) user!.adress = newAdress;
    isLoading = false;
    notifyListeners();
    return resp;
  }
}
