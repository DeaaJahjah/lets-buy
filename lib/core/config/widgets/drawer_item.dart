import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  const DrawerItem({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: purple,
                size: 20,
              ),
            ),
            Text(
              text,
              style: const TextStyle(color: purple, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
