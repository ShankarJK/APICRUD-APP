import 'package:flutter/material.dart';

class Styles {
  static TextStyle title = TextStyle(
      color: CommonColors.black, fontWeight: FontWeight.w700, fontSize: 20);
      static TextStyle data = TextStyle(
      color: CommonColors.black, fontWeight: FontWeight.w500, fontSize: 15);
  static TextStyle textFieldInputText =
      TextStyle(color: CommonColors.black, fontWeight: FontWeight.w300);

  static InputDecoration textFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: CommonColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: CommonColors.grey),
    ),
    filled: true,
    fillColor: CommonColors.transparent,
  );

  static ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(CommonColors.orange));
}

class CommonColors {
  static Color orange = Colors.orange;
  static Color transparent = Colors.transparent;
  static Color grey = Colors.grey;
  static Color black = Colors.black;
}
