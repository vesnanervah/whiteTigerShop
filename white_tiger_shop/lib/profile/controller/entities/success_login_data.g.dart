// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessLoginData _$SuccessLoginDataFromJson(Map<String, dynamic> json) =>
    SuccessLoginData(
      json['token'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuccessLoginDataToJson(SuccessLoginData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
