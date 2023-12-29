import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  int productID;
  String content;

  Review(this.productID, this.content);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
