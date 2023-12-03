// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      imgUrl: json['img_url'] as String,
      favourites: (json['favourites'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'img_url': instance.imgUrl,
      'favourites': instance.favourites,
    };
