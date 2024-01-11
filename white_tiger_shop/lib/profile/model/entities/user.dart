import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String email;
  int balance;
  String? adress;
  String? name;

  User(this.email, this.balance, this.adress, this.name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
