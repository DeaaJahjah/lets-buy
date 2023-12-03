import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/item_custome.dart';
import 'package:lets_buy/features/posts/screens/edit_post_screen.dart';

class MyPostsScreen extends StatefulWidget {
  static const String routeName = '/post_screen';
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
          backgroundColor: purple,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('منشوراتي', style: appBarTextStyle)),
      body: FutureBuilder<List<Post>>(
          future: PostDbService().myPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var myPosts = snapshot.data!;
              return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  itemCount: myPosts.length,
                  itemBuilder: (context, index) {
                    var post = myPosts[index];
                    return ItemCustom(
                      urlImage:
                          (post.photos!.isNotEmpty) ? post.photos!.first : null,
                      address: post.address.split(' ').first,
                      type: post.city,
                      category: post.category1,
                      price: post.price,
                      onDelete: () async {
                        await PostDbService().deletePost(post.id!);
                        setState(() {});
                      },
                      onEdit: () {
                        Navigator.pushNamed(context, EditPostScreen.routeName,
                            arguments: post);
                      },
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text('لا يوجد منشورات', style: style1));
          }),
    );
  }
}
