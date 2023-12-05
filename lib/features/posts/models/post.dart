import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  String? id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String address;
  @JsonKey(name: 'product_status')
  final String productStatus;
  final String city;
  final String category1;
  final String category2;
  List<String>? keywrds;
  final String description;
  final String price;
  final String symbol;
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  List<String>? photos;

  Post(
      {this.id,
      required this.userId,
      required this.address,
      required this.city,
      required this.productStatus,
      required this.category1,
      required this.category2,
      required this.description,
      required this.price,
      required this.symbol,
      required this.isAvailable,
      this.keywrds,
      this.photos});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.fromFirestore(DocumentSnapshot documentSnapshot) {
    Post post = Post.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    print(post.description);
    post.id = documentSnapshot.id;
    return post;
  }

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props =>
      [keywrds, id, userId, address, city, category1, category2, description, price, symbol, isAvailable, photos];
}
