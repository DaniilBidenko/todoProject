import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';

class SettingsScreen extends StatefulWidget {
  final Todo? todo;
  const SettingsScreen({Key? key, this.todo}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Переменные для хранения текущих цветов
  Color titleColor = Colors.black;
  Color descriptionColor = Colors.grey;
  Color createdDataColor = Colors.grey;
  Color iconTaskColor = Colors.grey;
  Color iconDeleteColor = Colors.grey;
  Color titleAppBarColor = const Color.fromARGB(255, 3, 32, 248);
  Color buttonSettingsTextColor = Colors.grey;
  Color buttonAddedTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _initializeColors();
  }

  // Инициализация цветов из сохраненных настроек
  Future<void> _initializeColors() async {
    final todoColor = await TodoColor.loadFromPrefs();
    final appBarColor = await AppBarColors.loadFromPrefs();
    
    setState(() {
      // Загружаем цвета TodoColor
      titleColor = todoColor.titleColor;
      descriptionColor = todoColor.descriptionColor;
      createdDataColor = todoColor.createdData;
      iconTaskColor = todoColor.iconTaskColor;
      iconDeleteColor = todoColor.iconDeleteColor;
      
      // Загружаем цвета AppBarColors
      titleAppBarColor = appBarColor.titleAppBarColor;
      buttonSettingsTextColor = appBarColor.buttonSettingsTextColor;
      buttonAddedTextColor = appBarColor.buttonAddedTextColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Title(
          color: Colors.black,
          child: Text(
            'Настройки',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Настройка цветов элементов задачи',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildColorOption('Цвет заголовка задачи', titleColor, (color) {
              setState(() => titleColor = color);
            }),
            _buildColorOption('Цвет описания задачи', descriptionColor, (color) {
              setState(() => descriptionColor = color);
            }),
            _buildColorOption('Цвет даты создания', createdDataColor, (color) {
              setState(() => createdDataColor = color);
            }),
            _buildColorOption('Цвет иконки задачи', iconTaskColor, (color) {
              setState(() => iconTaskColor = color);
            }),
            _buildColorOption('Цвет иконки удаления', iconDeleteColor, (color) {
              setState(() => iconDeleteColor = color);
            }),
            SizedBox(height: 20),
            Text(
              'Настройка цветов верхней панели',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildColorOption('Цвет заголовка AppBar', titleAppBarColor, (color) {
              setState(() => titleAppBarColor = color);
            }),
            _buildColorOption('Цвет кнопки настроек', buttonSettingsTextColor, (color) {
              setState(() => buttonSettingsTextColor = color);
            }),
            _buildColorOption('Цвет кнопки добавления', buttonAddedTextColor, (color) {
              setState(() => buttonAddedTextColor = color);
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveColors,
              child: Text('Сохранить настройки'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(String title, Color currentColor, Function(Color) onColorChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => _openColorPicker(context, currentColor, onColorChanged),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: currentColor,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openColorPicker(BuildContext context, Color currentColor, Function(Color) onColorChanged) {
    Color pickerColor = currentColor;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите цвет'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Выбрать'),
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveColors() async {
    // Создаем объекты с выбранными цветами для использования в приложении
    final TodoColor todoColor = TodoColor(
      titleColor: titleColor,
      descriptionColor: descriptionColor,
      createdData: createdDataColor,
      iconTaskColor: iconTaskColor,
      iconDeleteColor: iconDeleteColor,
    );

    final AppBarColors appBarColors = AppBarColors(
      titleAppBarColor: titleAppBarColor,
      buttonSettingsTextColor: buttonSettingsTextColor,
      buttonAddedTextColor: buttonAddedTextColor,
    );

    // Сохраняем цвета в SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(TodoColor.titleColorKey, titleColor.value);
    await prefs.setInt(TodoColor.descriptionColorKey, descriptionColor.value);
    await prefs.setInt(TodoColor.createdDataColorKey, createdDataColor.value);
    await prefs.setInt(TodoColor.iconTaskColorKey, iconTaskColor.value);
    await prefs.setInt(TodoColor.iconDeleteColorKey, iconDeleteColor.value);
    await prefs.setInt(AppBarColors.titleAppBarColorKey, titleAppBarColor.value);
    await prefs.setInt(AppBarColors.buttonSettingsTextColorKey, buttonSettingsTextColor.value);
    await prefs.setInt(AppBarColors.buttonAddedTextColorKey, buttonAddedTextColor.value);
    
    // Показываем сообщение об успешном сохранении
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Настройки успешно сохранены')),
    );
  }
}