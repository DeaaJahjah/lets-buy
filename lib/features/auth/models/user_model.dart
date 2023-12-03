import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  final String name;
  final String email;
  final String address;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'img_url')
  final String imgUrl;
  List<String>? favourites;

  UserModel(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.address,
      required this.imgUrl,
      this.favourites});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

    userModel.id = documentSnapshot.id;
    return userModel;
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  isFavouritePost(String id) {
    if (favourites == null) {
      return false;
    }
    return favourites!.contains(id);
  }
}
