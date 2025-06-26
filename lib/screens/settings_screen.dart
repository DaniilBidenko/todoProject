import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/bloc/color_bloc.dart';
import 'package:to_do/bloc/color_event.dart';
import 'package:to_do/bloc/color_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/homescreen.dart';

class SettingsScreen extends StatefulWidget{
  final Todo? todo;
  const SettingsScreen({Key? key, this.todo}) : super (key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState(); // создаем состояние 
}
class _SettingsScreenState extends State<SettingsScreen>{

  Color titleColor = Colors.black;
  Color descriptionColor = Colors.grey;
  Color createdDataColor = Colors.grey;
  Color iconTaskColor = Colors.grey;
  Color iconDeleteColor = Colors.grey;
  Color titleAppBarColor = const Color.fromARGB(255, 3, 32, 248);
  Color buttonSettingsTextColor = Colors.grey;
  Color buttonAddedTextColor = Colors.white;
  late TodoColor todoColor;
   Key _listKey = UniqueKey();

  Future<void> _loadTodoColors() async{
    final colors = await TodoColor.loadFromPrefs();
    setState(() {
      todoColor = colors;
    });
  }

     @override
  void initState() {
    super.initState();
    _initializeColors();
    todoColor = TodoColor();
    _loadTodoColors();
  }

   Future<void> _initializeColors() async {
    final todoColor = await TodoColor.loadFromPrefs();
    final appBarColor = await AppBarColors.loadFromPrefs();

    setState(() {
      titleColor = todoColor.titleColor;
      descriptionColor = todoColor.descriptionColor;
      createdDataColor = todoColor.createdData;
      iconTaskColor = todoColor.iconTaskColor;
      iconDeleteColor = todoColor.iconDeleteColor;
      
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
        child: Text('Найстройки',
        style: TextStyle(
          color:  Colors.black
        ),
        )),
      
    ),
      body: BlocBuilder<ColorBloc, ColorState>(
        builder: (context, state) {
          if(state is ColorLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ColorLoaded) {
            return _buildSettingsContent(context, state);
          } else if (state is ColorError) {
            return Center(
              child: Text('${state.massage}'),
            );
          } else {
            return Center(
              child: Text('Неизвестное состояние'),
            ); 
          }
        })
    );
    
  }

   Widget _buildSettingsContent (BuildContext context, ColorLoaded state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Настройка цветов задачи'),
          SizedBox(height: 20),
          _buildColorOption('Цвет заголовки задачи',
           state.todoColor.titleColor,
           (color) => context.read<ColorBloc>().add(ColorUpdateTitle(color))
          ), 
          SizedBox(height: 20),
          _buildColorOption('Цвет описания задачи',
           state.todoColor.descriptionColor,
           (color) => context.read<ColorBloc>().add(ColorUpdateDescription(color))
           ),
           SizedBox(height: 20),
           _buildColorOption('Цвет даты создания',
          state.todoColor.createdData,
          (color) => context.read<ColorBloc>().add(ColorUpdateCreatedData(color))
          ),
          SizedBox(height: 20),
          _buildColorOption('Цвет иконки редактирования задачи',
          state.todoColor.iconTaskColor, 
          (color) => context.read<ColorBloc>().add(ColorUpdateIconTask(color))
          ),
          SizedBox(height: 20),
          _buildColorOption('Цвет иконка удаления задачи',
          state.todoColor.iconDeleteColor,
          (color) => context.read<ColorBloc>().add(ColorUpdateIconDelete(color))
          ),
          SizedBox(height: 20),
          _buildColorOption('Цвет заголовка шапки',
          state.appBarColors.titleAppBarColor,
          (color) => context.read<ColorBloc>().add(ColorUpdateAppBarTitle(color))
          ),
          SizedBox(height: 20),
          _buildColorOption('Цвет текста кнопки добавления задачи',
          state.appBarColors.buttonAddedTextColor,
          (color) => context.read<ColorBloc>().add(ColorUpdateButtonAdded(color))
          ),
          SizedBox(height: 20),
          _buildColorOption('Цвет текста кнопки настроек',
          state.appBarColors.buttonSettingsTextColor,
          (color) => context.read<ColorBloc>().add(ColorUpdateButtonSettings(color))
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<ColorBloc>().add(SaveColors());
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Настройки сохранены успешно')));
            }, 
          child: Text('Сохранить настройки')
          
          ),
          
        ],
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