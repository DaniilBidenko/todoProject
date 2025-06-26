import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarColors {
   Color titleAppBarColor;
   Color buttonSettingsTextColor;
   Color buttonAddedTextColor;
  AppBarColors({
    this.buttonAddedTextColor = Colors.white,
    this.buttonSettingsTextColor = Colors.grey,
    this.titleAppBarColor = const Color.fromARGB(255, 3, 32, 248),
  });

  static const String titleAppBarColorKey = 'title_app_bar_color';
  static const String buttonSettingsTextColorKey = 'button_settings_text_color';
  static const String buttonAddedTextColorKey = 'button_added_text_color';

  static Future<AppBarColors> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return AppBarColors(
      titleAppBarColor: Color(prefs.getInt(titleAppBarColorKey) ?? const Color.fromARGB(255, 3, 32, 248).value),
      buttonSettingsTextColor: Color(prefs.getInt(buttonSettingsTextColorKey) ?? Colors.grey.value),
      buttonAddedTextColor: Color(prefs.getInt(buttonAddedTextColorKey) ?? Colors.white.value),
    );
}

  AppBarColors copyWith ({
    Color? titleAppBarColor,
    Color? buttonSettingsTextColor,
    Color? buttonAddedTextColor
  }) {
    return AppBarColors(
      titleAppBarColor: titleAppBarColor ?? this.titleAppBarColor,
      buttonSettingsTextColor: buttonSettingsTextColor ?? this.buttonSettingsTextColor,
      buttonAddedTextColor: buttonAddedTextColor ?? this.buttonAddedTextColor
    );
  }
}



class TodoColor {
   Color titleColor;
   Color descriptionColor;
   Color createdData;
   Color iconTaskColor;
   Color iconDeleteColor;
  TodoColor({
    this.createdData = Colors.grey,
    this.descriptionColor = Colors.grey,
    this.iconDeleteColor = Colors.grey,
    this.iconTaskColor = Colors.grey,
    this.titleColor = Colors.black
  });

  static const String titleColorKey = 'title_color';
  static const String descriptionColorKey = 'description_color';
  static const String createdDataColorKey = 'created_data_color';
  static const String iconTaskColorKey = 'icon_task_color';
  static const String iconDeleteColorKey = 'icon_delete_color';

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

  TodoColor copyWith ({
   Color? titleColor,
   Color? descriptionColor,
   Color? createdData,
   Color? iconTaskColor,
   Color? iconDeleteColor
  }) {
    return TodoColor(
    titleColor: titleColor ?? this.titleColor,
    descriptionColor: descriptionColor ?? this.descriptionColor,
    createdData: createdData ?? this.createdData,
    iconTaskColor: iconTaskColor ?? this.iconTaskColor,
    iconDeleteColor: iconDeleteColor ?? this.iconDeleteColor
    );
  }

}


