import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';
import 'package:lets_buy/core/config/extensions/firebase.dart';
import 'package:lets_buy/features/auth/screens/login_screen.dart';
import 'package:lets_buy/features/home_screen/home.dart';
import 'package:show_up_animation/show_up_animation.dart';
// import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      if (context.logedInUser != null) {
        //connect user to caht sdk
        // final client = StreamChatCore.of(context).client;
        // await client.connectUser(User(id: context.userUid!), context.userToken!);

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    });
    return Scaffold(
      backgroundColor: dark,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowUpAnimation(
              delayStart: const Duration(milliseconds: 50),
              animationDuration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
              direction: Direction.vertical,
              offset: 0.5,
              child: Column(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/logo.svg',
                  //   height: MediaQuery.sizeOf(context).height * 0.70,
                  // ),
                  Image.asset(
                    'assets/images/logo-with-text.png',
                    height: MediaQuery.sizeOf(context).height * 0.25,
                  ),
                  // sizedBoxSmall,
                  // const Text(
                  //   'Let\'s Buy',
                  //   style: TextStyle(fontSize: 24),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(color: purple),
                ],
              )),
        ],
      )),
    );
  }
}
