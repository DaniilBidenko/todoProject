
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/add_todo_screen.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/screens/statistick_todo_screen.dart';
import 'package:to_do/screens/tasks_screen.dart';

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
    double width = MediaQuery.of(context).size.width;
    double appBarButtonSize = width * 0.13;
    double appBarTitle = width * 0.020;
    double appBatText = width * 0.01;
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Задачник',
                  style: TextStyle(
                    fontSize: appBarTitle,
                    fontWeight: FontWeight.bold,
                    color:  appBarColors.titleAppBarColor
                    ),
                ),
                  Container(
                    width: appBarButtonSize,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 243, 245)),
                        ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TasksScreen()
                        ));
                      }, 
                      child: Text('Задачи',
                        style: TextStyle(
                        color: appBarColors.buttonSettingsTextColor,
                        fontSize: appBatText
                        ),
                      )
                    ),
                  ),
                    Container(
                      width: appBarButtonSize,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 243, 245)),
                      ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SettingsScreen()
                      ));
                    }, 
                    child: Text('Найстройки',
                      style: TextStyle(
                        color: appBarColors.buttonSettingsTextColor,
                        fontSize: appBatText
                      ),
                    )
                    ),
                    ),
                      Container(
                        width: appBarButtonSize,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 243, 245)),
                          ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StatistickTodoScreen()
                          ));
                        }, 
                        child: Text('Статистика',
                        style: TextStyle(
                          color: appBarColors.buttonSettingsTextColor,
                          fontSize: appBatText
                          ),
                        )
                        ),
                      ),
                        Container(
                          width: appBarButtonSize,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 3, 32, 248),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 3, 32, 248)),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddTodoScreen()
                                ));
                              }, 
                            child: Text('+ Добавить задачу',
                              style: TextStyle(
                                color: appBarColors.buttonAddedTextColor,
                                fontSize: appBatText
                              ),
                            )
                          ),
                        ),
              ]
          );
  }
}