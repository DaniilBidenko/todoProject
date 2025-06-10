import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/bloc/todo_state.dart';
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
    double width = MediaQuery.of(context).size.width;
    double appBarButtonSize = width * 0.16;
    double appBarTitle = width * 0.030;
    double appBatText = width * 0.017;
    double staticTast = width * 0.03;
    double analitik = width * 0.015;
    double staticDay = width * 0.017;
    double containersSize = width * 0.2;
    double vsegoZadach = width * 0.010;
    double dayContainer = width * 0.1;
    double dayContainerText = width * 0.012;
    double sizedBox = width * 0.35;
    
   return Scaffold(
    backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Row(
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
          ),
        ),
      ),
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
                    fontSize: staticTast,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: 50
                  ),
                child: Text('Аналитика показателей эеффективности наших задач',
                  style: TextStyle(
                    fontSize: analitik,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 50,
                    right: 40
                  ),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Статистика за неделю',
                        style: TextStyle(
                          fontSize: staticDay
                        ),
                      ),
                        SizedBox(width: sizedBox),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: dayContainer,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.blue; 
                                      }
                                        return Colors.white; 
                                    }),
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                      ))
                                  ),
                                    onPressed: () {}, 
                                      child: Text('Неделя',
                                        style: TextStyle(
                                          fontSize: dayContainerText
                                        ),
                                      )
                                ),
                              ),
                            Container(
                              width: dayContainer,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.blue; 
                                      } 
                                        return Colors.white; 
                                    }),
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                      ))
                                  ),
                                onPressed: () {}, 
                                  child: Text('Месяц',
                                    style: TextStyle(
                                      fontSize: dayContainerText
                                    ),
                                  )
                                ),
                            ),
                            Container(
                              width: dayContainer,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.blue; 
                                      }
                                        return Colors.white; 
                                    }),
                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                      ))
                                  ),
                                    onPressed: () {}, 
                                      child: Text('Год',
                                        style: TextStyle(
                                          fontSize: dayContainerText
                                        ),
                              )
                              ),
                            ),
                          ],
                        )
                        )
                    ],
                    ),
                  ),
              ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 50,
                    right: 40
                  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(                      
                            width: containersSize,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          ),
                            Container(                      
                              width: containersSize,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                                child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : getCompletedListTodo(state);
                                    } else if (state is TodoError) {
                                      return Center(
                                        child: Text('ошибка загрузки'),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text('Все пошло по бороде'),
                                      );
                                    }
                                  }
                                )
                            ),
                              Container(                       
                                width: containersSize,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                child: Text('Гачимучи'),
                              ),
                                Container(
                                  width: containersSize,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                    child: Text('Гачимучи'),
                                ),
                        ],
                    ),
                ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 50
                    ),
                      child: Container(
                        color: Colors.yellow,
                        height: 200,
                        width: 200,
                          child: BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : getDiagrammStatistick(state);
                              } else if (state is TodoError) {
                                return Center(
                                  child: Text('ошибка загрузки'),
                                );
                              } else {
                                return const Center(
                                  child: Text('Все пошло по бороде'),
                                );
                              }
                            }
                          )
                      )
                  )
          ],
        )
       ],
    ),
   );
   
  }

 int statistickTodo (List<Todo> todo,) {
    int isCompletedTasks = 0;
    for (int i = 0; i < todo.length; i++) {
      if (todo[i].isCompleted == true) {
       isCompletedTasks++;
      } 
    }
    print(statistickTodo(todo));
    return isCompletedTasks;
  }
 
        Widget getListTodo (TodoLoaded state) {
          final todos = state.todos;
            return Container(                      
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                                left: 0
                              ),
                                child: Icon(
                                  Icons.four_mp_sharp,
                                  size: 20,
                                ),
                            ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  left: 0
                                ),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                            left: 0
                                          ),
                                        child: Text('Всего задач : ${todos.length}',
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                        ),
                                      ],
                                    )
                                  ),
                              )
                          ],
                        )
                      );         
          }

 Widget getCompletedListTodo (TodoLoaded state) {
  final todos = state.todos;
  return Container(                      
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
              child: Text('Выполнено задач : ${todos.where((todos) => todos.isCompleted).length }'),
    );
 }
 Widget getDiagrammStatistick (TodoLoaded state) {
  final todos =  state.todos;
  return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 50
            ),
              child: Container(
                color: Colors.yellow,
                height: 200,
                width: 200,
                  child: SizedBox(
                    height: 150,
                    width: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: todos.length.toDouble(),
                              color: Colors.green
                            ),
                              PieChartSectionData(
                                value: todos.where((todos) => todos.isCompleted).length.toDouble(),
                                color: Colors.orange
                              )
                          ],
                        sectionsSpace: 5,
                        centerSpaceRadius: 40
                        )
                      ),
                  )
              ),
          );
    }
}