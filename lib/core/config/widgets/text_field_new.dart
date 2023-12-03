import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class TextFieldNew extends StatelessWidget {
  final String text;

  final IconData? icon;
  void Function(String)? onChanged;
  TextFieldNew({Key? key, required this.text, this.icon, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      style: const TextStyle(color: white, fontFamily: font, fontSize: 14),
      decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: white.withOpacity(0.5),
          ),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: purple, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: purple, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: text,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: purple, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle:
              TextStyle(color: white.withOpacity(0.5), fontFamily: font, fontSize: 16, fontWeight: FontWeight.normal)),
      onChanged: onChanged,
    );
  }
}
