import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';
import 'package:lets_buy/features/posts/models/post.dart';

class PostDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  addPost(Post post, BuildContext context) async {
    try {
      await _db.collection('posts').add(post.toJson());
    } on FirebaseException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<Post>> similerStuff(String category) async {
    var query = await _db
        .collection('posts')
        .where('category1', isEqualTo: category)
        .get();

    List<Post> posts = [];
    for (var doc in query.docs) {
      posts.add(Post.fromFirestore(doc));
    }
    return posts;
  }

  List<Post> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Post.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Post>> getPostsByCategory(String category) {
    if (category == 'الكل') {
      return _db
          .collection('posts')
          .where('is_available', isEqualTo: true)
          .snapshots()
          .map(_projectListFromSnapshot);
    }
    return _db
        .collection('posts')
        .where('is_available', isEqualTo: true)
        .where('category1', isEqualTo: category)
        .snapshots()
        .map(_projectListFromSnapshot);
  }

  Future<List<Post>> getPosts() async {
    var query = await _db
        .collection('posts')
        .where('is_available', isEqualTo: true)
        .get();

    List<Post> posts = [];
    for (var doc in query.docs) {
      posts.add(Post.fromFirestore(doc));
    }
    return posts;
  }

  Future<Post?> getPostById(String id) async {
    var doc = await _db.collection('posts').doc(id).get();
    if (doc.exists) {
      return Post.fromFirestore(doc);
    }

    return null;
  }

  Future<List<Post>> myPosts() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    List<Post> posts = [];

    var query =
        await _db.collection('posts').where('user_id', isEqualTo: uid).get();

    for (var doc in query.docs) {
      posts.add(Post.fromFirestore(doc));
    }
    return posts;
  }

  Future<void> deletePost(String id) async {
    await _db.collection('posts').doc(id).delete();
  }

  //update post
  Future<void> updatePost(Post post) async {
    await _db.collection('posts').doc(post.id).update(post.toJson());
  }

// my post count
  Future<int> myPostCount() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var query =
        await _db.collection('posts').where('user_id', isEqualTo: uid).get();
    return query.docs.length;
  }

  Future<List<Post>?> favourites() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var doc = await _db.collection('users').doc(userId).get();
    var user = UserModel.fromFirestore(doc);
    List<Post> posts = [];

    for (var fav in user.favourites ?? []) {
      var post = await getPostById(fav);
      if (post != null) {
        if (post.isAvailable) {
          posts.add(post);
        }
      }
    }
    return posts;
  }
}
