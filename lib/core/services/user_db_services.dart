import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
// import 'package:lets_buy/features/chat/services/stream_chat_service.dart';
import 'package:lets_buy/features/home_screen/home.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class UserDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var firebaseUser = auth.FirebaseAuth.instance.currentUser;

  creatUser(UserModel user, context) async {
    try {
      /// Create user documnet
      await _db.collection('users').doc(firebaseUser!.uid).set(user.toJson());

      /// Create user in Stream Chat
      // final client = StreamChatCore.of(context).client;

      // ///generate token id for this user
      // var token = client.devToken(firebaseUser!.uid);

      /// save the token as a display name
      /// and update user photo

      // await firebaseUser!.updateDisplayName(token.rawValue);
      // if (user.imgUrl != null)
      // firebaseUser!.updatePhotoURL(user.imgUrl),

      /// connect user to [Stream SDK]
      // await client.connectUser(
      //   User(
      //     id: firebaseUser!.uid,
      //     name: user.name,
      //     image: user.imgUrl,
      //   ),
      //   token.rawValue,
      // );

      // Provider.of<AuthSataProvider>(context, listen: false).changeAuthState(newState: AuthState.notSet);

      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (e) {
      // Provider.of<AuthSataProvider>(context, listen: false).changeAuthState(newState: AuthState.notSet);

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      var user = await _db.collection('users').doc(id).get();
      return UserModel.fromFirestore(user);
    } on FirebaseException catch (e) {
      print(e);
    }
    return null;
  }

  //update user
  Future<void> updateUser(UserModel user, BuildContext context) async {
    try {
      await _db.collection('users').doc(firebaseUser!.uid).update(user.toJson());
      // await StreamChatService().updateUser(user, context);
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  addToFivourites(String id) async {
    try {
      await _db.collection('users').doc(firebaseUser!.uid).update({
        'favourites': FieldValue.arrayUnion([id])
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // remove from favourites
  removeFromFavourites(String id) async {
    try {
      await _db.collection('users').doc(firebaseUser!.uid).update({
        'favourites': FieldValue.arrayRemove([id])
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
