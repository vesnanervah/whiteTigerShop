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

  @override
  bool? get data => isLogedIn;

  ProfileModel() {
    checkSavedToken();
  }

  Future<void> checkSavedToken() async {
    if (profileBox != null) return;
    profileBox = await Hive.openBox('profile');
    String? savedToken = profileBox!.get('token');
    String? savedEmail = profileBox!.get('email');
    if (savedToken != null && savedEmail != null) {
      isLogedIn = await api.loginByToken(savedEmail, savedToken);
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
  Future<void> fetch() {
    throw UnimplementedError();
  }

  Future<bool?> sumbitAuth(String code) async {
    if (isLoading) return null;
    isLoading = true;
    final (loged, recievedToken) = await api.confirmCode(email!, code);
    if (loged && recievedToken != null) {
      token = recievedToken;
      isLogedIn = true;
      mailSend = false;
      saveCreditsToLocal();
    } else {}
    notifyListeners();
    isLoading = false;
    return loged;
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
