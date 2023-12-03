import 'package:flutter/cupertino.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/search/data_provider.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  List<Post> filteredPosts = [];
  search(
      {required String query,
      required String category,
      required String type,
      required String keywords,
      required BuildContext context}) {
    List<Post> originalPosts =
        Provider.of<DataProvider>(context, listen: false).posts;

    filteredPosts = originalPosts.where((post) => post.city == type).toList();

    if (query.isNotEmpty) {
      filteredPosts = filteredPosts
          .where((post) =>
              post.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print('filterd ${filteredPosts.length}');
    if (category == 'Select') {
      filteredPosts =
          filteredPosts.where((post) => post.category1 != 'Select').toList();
    }
    if (category != 'Select') {
      filteredPosts =
          filteredPosts.where((post) => post.category1 == category).toList();
    }

    if (keywords.isNotEmpty) {
      List<String> tags = keywords.split(' ').toList();

      List<Post> tempPosts = [];
      for (var post in filteredPosts) {
        for (var tag in tags) {
          for (var element in post.keywrds!) {
            if (element.toLowerCase() == tag.toLowerCase()) {
              print('$element => $tag');
              tempPosts.add(post);
            }
          }
        }
      }
      filteredPosts = tempPosts;
    }

    print('filterd ${filteredPosts.length}');
    notifyListeners();
  }
}
