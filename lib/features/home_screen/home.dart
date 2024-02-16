import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/constant/keys.dart';
import 'package:lets_buy/core/config/enums/enums.dart';
import 'package:lets_buy/core/config/widgets/drawer_item.dart';
// import 'package:lets_buy/features/chat/messages_screen.dart';
import 'package:lets_buy/features/help/help_screen.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_navigation_bar.dart';
import 'package:lets_buy/features/posts/models/post.dart';
import 'package:lets_buy/features/posts/providers/posts_provider.dart';
import 'package:lets_buy/features/posts/screens/add_post.dart';
import 'package:lets_buy/features/posts/screens/favourite_screen.dart';
import 'package:lets_buy/features/posts/screens/my_posts_screen.dart';
import 'package:lets_buy/features/posts/services/post_db_service.dart';
import 'package:lets_buy/features/posts/widgets/category_card.dart';
import 'package:lets_buy/features/posts/widgets/porduct_card.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  String category = categoriesHome[0].name;
  bool isSwitched = true;
  bool loading = true;

  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    context.read<UserInfoProvider>().getUserInfo(uid: uid).then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterFireAuthServices().signOut(context);

    return Scaffold(
        backgroundColor: dark,
        bottomNavigationBar: CustomNavigationBar(index: 2),
        appBar: AppBar(
          centerTitle: true,
          actions: const [
            // StreamBuilder<int>(
            //     stream: StreamChatCore.of(context).client.state.totalUnreadCountStream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Stack(
            //           children: [
            //             IconButton(
            //               icon: const Icon(Icons.message),
            //               onPressed: () {
            //                 Navigator.of(context).pushNamed(MessagesScreen.routeName);
            //               },
            //             ),
            //             if (snapshot.data != 0)
            //               CircleAvatar(
            //                 backgroundColor: purple,
            //                 radius: 10,
            //                 child: Text(
            //                   snapshot.data.toString(),
            //                   style: const TextStyle(color: white, fontSize: 8),
            //                 ),
            //               )
            //           ],
            //         );
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(color: purple),
            //         );
            //       }
            //       return const SizedBox.shrink();
            //     })
          ],
          backgroundColor: dark,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 65),
              Image.asset(
                'assets/images/logo.png',
                // scale: 4,
                height: 30,
              ),
              const Text('Let\'s Buy', style: appBarTextStyle),
            ],
          ),
        ),
        drawer: Drawer(
            backgroundColor: white,
            child: Column(children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: dark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
                  if (provider.dataState == DataState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        CircleAvatar(
                          backgroundColor: purple,
                          radius: 50,
                          backgroundImage: NetworkImage(
                            provider.user!.imgUrl,
                            scale: 4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          provider.user!.name,
                          style: const TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          provider.user!.email,
                          style: const TextStyle(color: white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: purple),
                  );
                }),
              ),
              sizedBoxLarge,
              DrawerItem(
                  icon: Icons.favorite,
                  text: 'المحفوظات',
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(FavouriteScreen.routeName);
                  }),
              sizedBoxSmall,
              DrawerItem(
                  icon: Icons.post_add,
                  text: 'منشوراتي',
                  onTap: () {
                    Navigator.of(context).pushNamed(MyPostsScreen.routeName);
                  }),
              sizedBoxSmall,
              // DrawerItem(
              //     icon: Icons.message,
              //     text: 'الرسائل',
              //     onTap: () {
              //       Navigator.of(context).pushNamed(MessagesScreen.routeName);
              //     }),
              // sizedBoxSmall,
              DrawerItem(
                  icon: Icons.add_box,
                  text: 'اضافة منشور',
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(AddPostScreen.routeName);
                  }),
              sizedBoxSmall,
              DrawerItem(
                  icon: Icons.help,
                  text: 'مركز المساعدة',
                  onTap: () {
                    Navigator.of(context).pushNamed(HelpScreen.routeName);
                  })
            ])),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  backgroundColor: dark,
                  pinned: false,
                  snap: true,
                  floating: true,
                  toolbarHeight: 180,
                  leading: const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'الأصناف',
                            style: TextStyle(fontSize: 20, fontFamily: font, color: white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryCard(
                                name: categoriesHome[index].name,
                                url: categoriesHome[index].urlImage,
                                onTap: () {
                                  for (int i = 0; i < categoriesHome.length; i++) {
                                    if (i == index) {
                                      categoriesHome[i].isSelected = true;
                                      category = categoriesHome[i].name;
                                      setState(() {});
                                    } else {
                                      categoriesHome[i].isSelected = false;
                                    }
                                    setState(() {});
                                  }
                                },
                                isSelected: categoriesHome[index].isSelected),
                            itemCount: categoriesHome.length,
                          ),
                        ),
                      ],
                    ),
                  )),
            ];
          },
          body: (!loading)
              ? StreamBuilder<List<Post>>(
                  key: Keys.postsStreamKey,
                  stream: PostDbService().getPostsByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Post> posts = snapshot.data!;
                      print(posts.length);

                      return GridView.builder(
                          itemCount: posts.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: kIsWeb ? 4 : 2,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 2,
                          ),
                          itemBuilder: (context, i) {
                            return ProductCard(
                              postId: posts[i].id!,
                              imageProduct: (posts[i].photos!.isNotEmpty) ? posts[i].photos!.first : null,
                              address: posts[i].address,
                              isFavorite: context.watch<UserInfoProvider>().user!.isFavouritePost(posts[i].id!),
                              type: posts[i].city,
                              price: posts[i].price,
                              productStatus: posts[i].productStatus,
                            );
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: purple),
                      );
                    }
                    return const SizedBox.shrink();
                  })
              : const Center(child: CircularProgressIndicator(color: purple)),
        ));
  }
}
