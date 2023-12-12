// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['productId'] as int,
      json['title'] as String,
      json['price'] as int,
      imageUrl: json['imageUrl'] as String?,
      productDescription: json['productDescription'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'productDescription': instance.productDescription,
      'category': instance.category,
    };
