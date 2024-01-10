import 'package:json_annotation/json_annotation.dart';
import 'package:white_tiger_shop/profile/model/entities/user.dart';

part 'success_login_data.g.dart';

@JsonSerializable()
class SuccessLoginData {
  String token;
  User user;

  SuccessLoginData(this.token, this.user);

  factory SuccessLoginData.fromJson(Map<String, dynamic> json) =>
      _$SuccessLoginDataFromJson(json);
}
