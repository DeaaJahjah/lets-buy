import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class HelpScreen extends StatelessWidget {
  static const String routeName = '/help_screen';
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
          backgroundColor: purple,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('مركز المساعدة', style: appBarTextStyle)),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
