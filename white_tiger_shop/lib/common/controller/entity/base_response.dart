import 'package:json_annotation/json_annotation.dart';
import 'package:white_tiger_shop/common/controller/entity/meta_of_resp.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResp {
  MetaOfResp meta;
  dynamic data;

  BaseResp(this.meta, this.data);

  factory BaseResp.fromJson(Map<String, dynamic> json) =>
      _$BaseRespFromJson(json);
}
