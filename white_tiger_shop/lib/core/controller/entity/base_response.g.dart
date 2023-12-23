// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResp _$BaseRespFromJson(Map<String, dynamic> json) => BaseResp(
      MetaOfResp.fromJson(json['meta'] as Map<String, dynamic>),
      json['data'],
    );

Map<String, dynamic> _$BaseRespToJson(BaseResp instance) => <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };
