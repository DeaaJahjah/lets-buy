import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: purple,
    ));
  }
}
