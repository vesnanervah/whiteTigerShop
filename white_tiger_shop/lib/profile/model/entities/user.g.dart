// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['email'] as String,
    json['balance'] as int,
    json['adress'] as String?,
    json['name'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'balance': instance.balance,
      'adress': instance.adress,
      'name': instance.name,
    };
