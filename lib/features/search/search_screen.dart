import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/services/user_db_services.dart';
import 'package:lets_buy/features/home_screen/widgets/custom_navigation_bar.dart';
import 'package:lets_buy/core/config/widgets/drop_down_custom.dart';
import 'package:lets_buy/features/posts/widgets/porduct_card.dart';
import 'package:lets_buy/core/config/widgets/text_field_new.dart';
import 'package:lets_buy/features/search/data_provider.dart';
import 'package:lets_buy/features/search/search_provider.dart';
import 'package:provider/provider.dart';

import '../auth/models/user_model.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search_screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> categoriesKeys = categories.keys.toList();
  ScrollController controller = ScrollController();
  UserModel? userModel;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  String type = '';
  String category = '';
  String keywords = '';
  String query = '';
  bool loading = true;
  @override
  void initState() {
    type = cities[0];
    category = categoriesKeys[0];
    UserDbServices().getUser(uid).then((value) {
      setState(() {
        userModel = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Provider.of<SearchProvider>(context, listen: false).filteredPosts = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    Provider.of<DataProvider>(context, listen: false).fecthData();
    print(category);
    return Scaffold(
        bottomNavigationBar: CustomNavigationBar(index: 3),
        backgroundColor: dark,
        appBar: AppBar(
            backgroundColor: purple,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              'بحث',
              style: TextStyle(color: white, fontFamily: font, fontWeight: FontWeight.bold, fontSize: 22),
            )),
        body: ListView(
          controller: controller,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: SizedBox(
                  height: 45,
                  child: TextFieldNew(
                    text: 'عن ماذا تبحث؟',
                    icon: Icons.search,
                    onChanged: (value) {
                      query = value;
                      searchProvider.search(
                          query: query, category: category, type: type, keywords: keywords, context: context);
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: DropDownCustom(
                      categories: cities,
                      selectedItem: type,
                      onChanged: (String? newValue) {
                        setState(() {
                          type = newValue!;
                        });
                        searchProvider.search(
                            query: query, category: category, type: type, keywords: keywords, context: context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: DropDownCustom(
                      categories: categoriesKeys,
                      selectedItem: category,
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                        searchProvider.search(
                            query: query, category: category, type: type, keywords: keywords, context: context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Text('الكلمات المفتاحية', style: appBarTextStyle),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
              child: SizedBox(
                  height: 45,
                  child: TextFieldNew(
                    text: 'مثال: ملابس لابتوب',
                    icon: Icons.abc,
                    onChanged: (value) {
                      keywords = value;
                      searchProvider.search(
                          query: query, category: category, type: type, keywords: keywords, context: context);
                    },
                  )),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Text('عمليات البحث السابقة', style: appBarTextStyle),
            ),
            (!loading)
                ? Consumer<SearchProvider>(builder: (context, posts, child) {
                    if (posts.filteredPosts.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Column(
                            children: [
                              Text('لا يوجد', style: style1),
                              Icon(Icons.close_rounded),
                            ],
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      // height: 200,
                      child: GridView.builder(
                        itemCount: posts.filteredPosts.length,
                        controller: controller,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 350, mainAxisSpacing: 20, crossAxisSpacing: 2, mainAxisExtent: 250),
                        itemBuilder: (BuildContext context, int i) {
                          var post = posts.filteredPosts[i];
                          return ProductCard(
                            postId: post.id!,
                            imageProduct: (post.photos!.isNotEmpty) ? post.photos!.first : null,
                            address: post.address,
                            isFavorite: userModel!.isFavouritePost(post.id!),
                            type: post.city,
                            price: post.price,
                            productStatus: post.productStatus,
                          );
                        },
                      ),
                    );
                  })
                : const Center(
                    child: CircularProgressIndicator(color: purple),
                  )
          ],
        ));
  }
}
