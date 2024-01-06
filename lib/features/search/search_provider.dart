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
    List<Post> originalPosts = Provider.of<DataProvider>(context, listen: false).posts;

    filteredPosts = originalPosts;

    ///Filter by description
    if (query.isNotEmpty) {
      filteredPosts =
          filteredPosts.where((post) => post.description.toLowerCase().contains(query.toLowerCase())).toList();
    }

    //Filter by city
    filteredPosts = filteredPosts.where((post) => post.city == type).toList();

    //Filter by category

    if (category != 'اختر') {
      filteredPosts = filteredPosts.where((post) => post.category1 == category).toList();
    }

    if (keywords.isNotEmpty) {
      print('keyworss $keywords');

      List<String> tags = keywords.split(' ').toList();

      for (var post in originalPosts) {
        if (post.keywrds!.any((element) => tags.contains(element.toLowerCase()))) {
          filteredPosts.add(post);
          print('fondedd');
        } else {
          filteredPosts.remove(post);
        }
        // for (var tag in tags) {
        //   for (var element in post.keywrds!) {
        //     if (element.toLowerCase() == tag.toLowerCase()) {
        //       print('$element => $tag');
        //       tempPosts.add(post);
        //     }
        //   }
      }
    }

    filteredPosts.unique();

    print('filterd ${filteredPosts.length}');
    notifyListeners();
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
