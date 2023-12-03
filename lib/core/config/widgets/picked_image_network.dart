import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class PickedImageNetwok extends StatelessWidget {
  final String url;
  final Function() onTap;

  const PickedImageNetwok({Key? key, required this.url, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          color: dark,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Image.network(
              url,
              fit: BoxFit.fill,
            ),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Positioned(
            top: 5,
            right: 2,
            child: InkWell(
              onTap: onTap,
              child: const CircleAvatar(
                backgroundColor: purple,
                radius: 12,
                child: Icon(
                  Icons.close,
                  color: white,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
