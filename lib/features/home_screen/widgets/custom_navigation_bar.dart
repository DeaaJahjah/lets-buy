import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:lets_buy/features/profile/profile_screen.dart';
import 'package:lets_buy/features/posts/screens/add_post.dart';
import 'package:lets_buy/features/posts/screens/favourite_screen.dart';
import 'package:lets_buy/features/search/search_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  final int index;
  CustomNavigationBar({Key? key, required this.index}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List<TabItem> items = [
    TabItem(Icons.add, 'اضافة', white, labelStyle: textStyle),
    TabItem(Icons.favorite, 'المفضلة', white, labelStyle: textStyle),
    TabItem(Icons.home, 'الرئيسية', white, labelStyle: textStyle),
    TabItem(Icons.search, 'بحث', white, labelStyle: textStyle),
    TabItem(Icons.person, 'الملف الشخصي', white, labelStyle: textStyle),
  ];

  CircularBottomNavigationController? navigationController;

  @override
  void initState() {
    navigationController = CircularBottomNavigationController(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      items,
      barBackgroundColor: const Color.fromARGB(255, 167, 126, 214),
      controller: navigationController,
      normalIconColor: white,
      iconsSize: 25,
      selectedIconColor: purple,
      selectedCallback: (int? index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed(AddPostScreen.routeName);
            break;
          case 1:
            Navigator.of(context)
                .pushReplacementNamed(FavouriteScreen.routeName);
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            break;
          case 3:
            Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
            break;
          case 4:
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            break;
        }
      },
    );
  }
}
