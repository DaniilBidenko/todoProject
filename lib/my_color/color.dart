import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarColors {
  final Color titleAppBarColor;
  final Color buttonSettingsTextColor;
  final Color buttonAddedTextColor;
  AppBarColors({
    this.buttonAddedTextColor = Colors.white,
    this.buttonSettingsTextColor = Colors.grey,
    this.titleAppBarColor = const Color.fromARGB(255, 3, 32, 248),
  });

  // Ключи для SharedPreferences
  static const String titleAppBarColorKey = 'title_app_bar_color';
  static const String buttonSettingsTextColorKey = 'button_settings_text_color';
  static const String buttonAddedTextColorKey = 'button_added_text_color';

  // Статический метод для загрузки цветов AppBar из SharedPreferences
  static Future<AppBarColors> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return AppBarColors(
      titleAppBarColor: Color(prefs.getInt(titleAppBarColorKey) ?? const Color.fromARGB(255, 3, 32, 248).value),
      buttonSettingsTextColor: Color(prefs.getInt(buttonSettingsTextColorKey) ?? Colors.grey.value),
      buttonAddedTextColor: Color(prefs.getInt(buttonAddedTextColorKey) ?? Colors.white.value),
    );
  }
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

  // Ключи для SharedPreferences
  static const String titleColorKey = 'title_color';
  static const String descriptionColorKey = 'description_color';
  static const String createdDataColorKey = 'created_data_color';
  static const String iconTaskColorKey = 'icon_task_color';
  static const String iconDeleteColorKey = 'icon_delete_color';

  // Статический метод для загрузки цветов Todo из SharedPreferences
  static Future<TodoColor> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return TodoColor(
      titleColor: Color(prefs.getInt(titleColorKey) ?? Colors.black.value),
      descriptionColor: Color(prefs.getInt(descriptionColorKey) ?? Colors.grey.value),
      createdData: Color(prefs.getInt(createdDataColorKey) ?? Colors.grey.value),
      iconTaskColor: Color(prefs.getInt(iconTaskColorKey) ?? Colors.grey.value),
      iconDeleteColor: Color(prefs.getInt(iconDeleteColorKey) ?? Colors.grey.value),
    );
  }
}

