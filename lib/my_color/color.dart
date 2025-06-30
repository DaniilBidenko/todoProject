import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/bloc/color_bloc.dart';
import 'package:to_do/data/database/database_helper.dart';

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
    final db = DatabaseHelper();

    final titleAppBarColor = await db.getColorSettings(titleAppBarColorKey);
    final buttonSettingsTextColor = await db.getColorSettings(buttonSettingsTextColorKey);
    final buttonAddedTextColor = await db.getColorSettings(buttonAddedTextColorKey);

    return AppBarColors(
      titleAppBarColor: Color(titleAppBarColor ?? const Color.fromARGB(255, 3, 32, 248).toARGB32()),
      buttonSettingsTextColor: Color(buttonSettingsTextColor ?? Colors.grey.toARGB32()),
      buttonAddedTextColor: Color(buttonAddedTextColor ?? Colors.grey.toARGB32()),
    );
}

   Future<void> saveAppBarColors() async{
      final db = await DatabaseHelper();

      await db.setColorSettings(titleAppBarColorKey, titleAppBarColor.toARGB32());
      await db.setColorSettings(buttonSettingsTextColorKey, buttonSettingsTextColor.toARGB32());
      await db.setColorSettings(buttonAddedTextColorKey, buttonAddedTextColor.toARGB32());
    }

    AppBarColors copyWith({
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
    final db =  DatabaseHelper();

    final titleColor = await db.getColorSettings(titleColorKey);
    final descriprionColor = await db.getColorSettings(descriptionColorKey);
    final createdData = await db.getColorSettings(createdDataColorKey);
    final iconTaskColor = await db.getColorSettings(iconTaskColorKey);
    final iconDelete = await db.getColorSettings(iconDeleteColorKey);

    return TodoColor(
      titleColor: Color(titleColor ?? Colors.black.toARGB32()),
      descriptionColor: Color(descriprionColor ?? Colors.grey.toARGB32()),
      createdData: Color(createdData ?? Colors.grey.toARGB32()),
      iconTaskColor: Color(iconTaskColor ?? Colors.grey.toARGB32()),
      iconDeleteColor: Color(iconDelete ?? Colors.grey.toARGB32())
    );
  }

  Future<void> saveTodoColors () async{
    final db = await DatabaseHelper();

    await db.setColorSettings(titleColorKey, titleColor.toARGB32());
    await db.setColorSettings(descriptionColorKey, descriptionColor.toARGB32());
    await db.setColorSettings(createdDataColorKey, createdData.toARGB32());
    await db.setColorSettings(iconTaskColorKey, iconTaskColor.toARGB32());
    await db.setColorSettings(iconDeleteColorKey, iconDeleteColor.toARGB32());
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


