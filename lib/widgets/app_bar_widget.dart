
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/add_todo_screen.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/screens/statistick_todo_screen.dart';

class AppBarWidget extends StatefulWidget{

  const AppBarWidget ({Key? key}) : super(key: key);
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {

  late AppBarColors appBarColors;
  
  @override
  void initState() {
    super.initState();
    appBarColors = AppBarColors();
    _loadColors();
  }

  Future<void> _loadColors() async{
    final colors = await AppBarColors.loadFromPrefs();
    setState(() {
      appBarColors = colors;
    });
  }
  @override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final isCompact = width < 500;

  final double titleSize = isCompact ? 15 : 19;
  final double buttonTextSize = isCompact ? 10 : 15;
  final double buttonWidth = isCompact ? 75 : 90;



  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text('Задачник',
        style: TextStyle(
          fontSize: titleSize,
          fontWeight: FontWeight.bold,
          color: appBarColors.titleAppBarColor,
        ),
      ),
      _buildButton('Настройки', buttonWidth, buttonTextSize, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
      }),
      _buildButton('Статистика', buttonWidth, buttonTextSize, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => StatistickTodoScreen()));
      }),
      // _buildButton('+', buttonWidth, buttonTextSize + 1, () {
      //   Navigator.push(context, MaterialPageRoute(builder: (_) => AddTodoScreen()));
      // }, isPrimary: true),
    ],
  );
}

Widget _buildButton(String label, double width, double fontSize, VoidCallback onTap, {bool isPrimary = false}) {
  return Container(
    width: width,
    height: 30,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFF0320F8) : const Color(0xFFF3F3F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Text(label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: isPrimary ? appBarColors.buttonAddedTextColor : appBarColors.buttonSettingsTextColor,
        ),
      ),
    ),
  );
}
  
}
