import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/add_todo_screen.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/screens/tasks_screen.dart';

class StatistickTodoScreen extends StatefulWidget {
  final Todo? todo;
  StatistickTodoScreen({Key? key, this.todo}) : super (key: key);

  @override
  _StatistickTodoScreenState createState() => _StatistickTodoScreenState();
}

class _StatistickTodoScreenState extends State<StatistickTodoScreen> {

    Key _listKey = UniqueKey();

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
   return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Задачник',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color:  appBarColors.titleAppBarColor
        ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => TasksScreen()
              )).then((_) {
                // После возвращения с экрана настроек, перезагружаем цвета
                _loadColors();
                setState(() {
                  _listKey = UniqueKey();
                });
              });
          }, 
          child: Text('Задачи',
          style: TextStyle(
            color: appBarColors.buttonSettingsTextColor
          ),
          )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SettingsScreen()
              )).then((_) {
                // После возвращения с экрана настроек, перезагружаем цвета
                _loadColors();
                setState(() {
                  _listKey = UniqueKey();
                });
              });
          }, 
          child: Text('Настройки',
          style: TextStyle(
            color: appBarColors.buttonSettingsTextColor
          ),
          )),
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => StatistickTodoScreen()
              ));
          }, 
          child: Text('Статистика',
          style: TextStyle(
            color: appBarColors.buttonSettingsTextColor
          ),
          )),
        Container(
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
            color: appBarColors.buttonAddedTextColor
          ),)
          ),
        )
            ]
          ),
            
          ),),
    body: ListView(
       children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 50
              ),
              child: Text('Статистика задач',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              ),
              Padding
              (padding: EdgeInsets.only(
                top: 5,
                left: 50
              ),
              child: Text('Аналитика показателей эеффективности наших задач',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400
              ),
              ),
              )
          ],
        )
       ],
    ),
   );
   
  }
}