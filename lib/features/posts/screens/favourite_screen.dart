import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_navigation_bar.dart';
import 'package:lets_buy/features/posts/widgets/item_custome.dart';

class FavouriteScreen extends StatefulWidget {
  static const String routeName = '/favourite_screen';
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(index: 1),
      backgroundColor: dark,
      appBar: AppBar(
          backgroundColor: purple,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('المحفوظات', style: appBarTextStyle)),
      body: FutureBuilder<List<Post>?>(
          future: PostDbService().favourites(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var favorites = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  var post = favorites[index];
                  return ItemCustom(
                    urlImage:
                        (post.photos!.isNotEmpty) ? post.photos!.first : null,
                    address: post.address,
                    type: post.city,
                    category: post.category1,
                    price: post.price,
                    onDelete: () async {
                      await UserDbServices().removeFromFavourites(post.id!);
                      setState(() {});
                    },
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
