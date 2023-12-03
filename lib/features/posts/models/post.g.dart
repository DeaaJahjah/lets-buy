// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      productStatus: json['product_status'] as String,
      category1: json['category1'] as String,
      category2: json['category2'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      symbol: json['symbol'] as String,
      isAvailable: json['is_available'] as bool,
      keywrds:
          (json['keywrds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'address': instance.address,
      'city': instance.city,
      'product_status': instance.productStatus,
      'category1': instance.category1,
      'category2': instance.category2,
      'keywrds': instance.keywrds,
      'description': instance.description,
      'price': instance.price,
      'symbol': instance.symbol,
      'is_available': instance.isAvailable,
      'photos': instance.photos,
    };
