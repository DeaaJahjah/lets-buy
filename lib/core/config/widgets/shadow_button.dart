import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class ShadowButton extends StatelessWidget {
  const ShadowButton({Key? key, this.onTap, required this.title}) : super(key: key);

  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: purple,
            boxShadow: [BoxShadow(offset: Offset(-2, 2), spreadRadius: 1, blurRadius: 2, color: Colors.black54)]),
        child: Text(title),
      ),
    );
  }
}
