import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/screens/statistick_todo_screen.dart';


class AppBarWidget extends StatefulWidget{

  const AppBarWidget ({Key? key}) : super(key: key);
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {

  late AppBarColors appBarColors;
  
  Key _listKey = UniqueKey();
  
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
    double width = MediaQuery.of(context).size.width;
    double appBarTitle = width * 0.03;
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Задачник',
                  style: TextStyle(
                    fontSize: appBarTitle,
                    fontWeight: FontWeight.bold,
                    color:  appBarColors.titleAppBarColor
                    ),
                ),
                   appbarButtons ('Настройки', width * 0.15, () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SettingsScreen()
                        )).then((_) {
                          // После возвращения с экрана настроек, перезагружаем цвета
                          _loadColors();
                          setState(() {
                            _listKey = UniqueKey();
                          });
                        });
                   }),
                   appbarButtons('Статистика', width * 0.15, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StatistickTodoScreen()));
                   })
              ]
          );
  }

  Widget appbarButtons (String label, double appBarButtonSize, VoidCallback onTap) {
    double width = MediaQuery.of(context).size.width;
    double appBatText = width * 0.015;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        foregroundColor: Colors.grey,
                        side: BorderSide.none,
                        overlayColor: Colors.transparent
                      ),
                    onPressed: onTap,
                    child: Text(label,
                      style: TextStyle(
                        color: appBarColors.buttonSettingsTextColor,
                        fontSize: appBatText
                      ),
                    )
                    );
                    
  }
}
