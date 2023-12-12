import 'package:json_annotation/json_annotation.dart';

part 'meta_of_resp.g.dart';

@JsonSerializable()
class MetaOfResp {
  bool success;
  String error;

  MetaOfResp(this.success, this.error);

  factory MetaOfResp.fromJson(Map<String, dynamic> json) =>
      _$MetaOfRespFromJson(json);
}
