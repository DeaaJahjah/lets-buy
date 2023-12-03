import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class TextRow extends StatelessWidget {
  final String title;
  final String data;
  const TextRow({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
      child: Row(children: [
        Text(title,
            style: const TextStyle(
              color: purple,
              fontFamily: font,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        Expanded(
            child: Text(data,
                style: const TextStyle(
                  color: white,
                  fontFamily: font,
                  fontSize: 14,
                ),
                overflow: TextOverflow.clip)),
      ]),
    );
  }
}
