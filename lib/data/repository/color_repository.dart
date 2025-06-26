// import 'dart:convert';

// import 'package:flutter/rendering.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ColorRepository {
//    static const String _colorKey = 'colors'; 

//    Future<List<Color>> getAllTodos () async {
//     final prefs = await SharedPreferences.getInstance (); // инициализация локального хранилища
//     final colorsJson = prefs.getStringList(_colorKey) ?? []; // если локальное хранилище с ключом todoskey пустое, вернет пустой массив иначе вернет массив наших задач
    
//     return colorsJson.map((colorStr) {
//       final colorMap = jsonDecode(colorStr) as Map<String, dynamic>; // Делаем наш массив как обьект
//       return Color.fromJson(colorMap); // возвращает новую map при помощи метода класса Todo
//     }).toList();
// }