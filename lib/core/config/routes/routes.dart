import 'package:flutter/material.dart';
import 'package:lets_buy/features/auth/screens/login_screen.dart';
import 'package:lets_buy/features/auth/screens/sign_up_screen.dart';
import 'package:lets_buy/features/auth/screens/verfiy_phone_number_screen.dart';

import 'package:lets_buy/features/chat/messages_screen.dart';

import 'package:lets_buy/features/home_screen/home.dart';
import 'package:lets_buy/features/profile/profile_screen.dart';
import 'package:lets_buy/features/profile/update_profile_screen.dart';
import 'package:lets_buy/features/posts/screens/add_post.dart';
import 'package:lets_buy/features/posts/screens/details_screen.dart';
import 'package:lets_buy/features/posts/screens/edit_post_screen.dart';
import 'package:lets_buy/features/posts/screens/favourite_screen.dart';
import 'package:lets_buy/features/help/help_screen.dart';
import 'package:lets_buy/features/posts/screens/my_posts_screen.dart';

import 'package:lets_buy/features/search/search_screen.dart';
import 'package:lets_buy/features/splash_screen/splash_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const LoginScreen()));
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SignUpScreen()));
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const HomeScreen()));
    case SearchScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SearchScreen()));
    case FavouriteScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const FavouriteScreen()));
    case MessagesScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const MessagesScreen()));
    case MyPostsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const MyPostsScreen()));
    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const ProfileScreen()));
    case AddPostScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const AddPostScreen()));

    case DetailsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => DetailsScreen()));

    case EditPostScreen.routeName:
      return MaterialPageRoute(
          builder: ((_) => const EditPostScreen()), settings: settings);
    case UpdateProfileScreen.routeName:
      return MaterialPageRoute(
          builder: ((_) => const UpdateProfileScreen()), settings: settings);

    case HelpScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const HelpScreen()));

    case VerfiyPhoneNumberScree.routeName:
      return MaterialPageRoute(
          builder: ((_) => const VerfiyPhoneNumberScree()), settings: settings);
  }

  return null;
}
