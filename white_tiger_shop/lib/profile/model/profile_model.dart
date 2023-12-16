import 'package:hive_flutter/adapters.dart';
import 'package:white_tiger_shop/common/model/base_model.dart';

class ProfileModel extends BaseModel {
  bool? isLogedIn;
  String? token;
  Box? profileBox;

  @override
  bool? get data => isLogedIn;

  ProfileModel() {
    checkSavedToken();
  }

  Future<void> checkSavedToken() async {
    profileBox = await Hive.openBox('profile');
    String? savedToken = profileBox!.get('token');
    if (savedToken != null) {
      token = savedToken;
      // Todo: token request to check if token is active
    } else {
      isLogedIn = false;
    }
  }

  @override
  Future<void> fetch() {
    // TODO: read access token from local and post to server
    throw UnimplementedError();
  }
}
