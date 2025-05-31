import 'package:flutter/material.dart';

class AppBarColors {
  final Color titleAppBarColor;
  final Color buttonSettingsTextColor;
  final Color buttonAddedTextColor;
  AppBarColors({
    this.buttonAddedTextColor = Colors.white,
    this.buttonSettingsTextColor = Colors.grey,
    this.titleAppBarColor = const Color.fromARGB(255, 3, 32, 248),
  });
}

class TodoColor {
  final Color titleColor;
  final Color descriptionColor;
  final Color createdData;
  final Color iconTaskColor;
  final Color iconDeleteColor;
  TodoColor({
    this.createdData = Colors.grey,
    this.descriptionColor = Colors.grey,
    this.iconDeleteColor = Colors.grey,
    this.iconTaskColor = Colors.grey,
    this.titleColor = Colors.black
  });
}

