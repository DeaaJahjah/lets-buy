import 'package:flutter/material.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';

class DataProvider extends ChangeNotifier {
  List<Post> posts = [];

  fecthData() async {
    posts = await PostDbService().getPosts();
    notifyListeners();
  }
}
