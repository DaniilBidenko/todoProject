
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/widgets/app_bar_widget.dart';
import 'package:to_do/widgets/diagram_two_widget.dart';
import 'package:to_do/widgets/diagram_widget.dart';
import 'package:to_do/widgets/statistick_containers_widget.dart';

class StatistickTodoScreen extends StatefulWidget {
  final Todo? todo;
  StatistickTodoScreen({Key? key, this.todo}) : super (key: key);
  @override
  _StatistickTodoScreenState createState() => _StatistickTodoScreenState();
}
class _StatistickTodoScreenState extends State<StatistickTodoScreen> {
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
    double staticaZadach = width * 0.02;
    double analitika = width * 0.01;
    double staticDay = width * 0.012;
    double dayContainer = width * 0.0650;
    double dayContainerText = width * 0.006;
    double sizedBox = width * 0.35;
    
   return Scaffold(
    backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      appBar: AppBar(
        title: Title(
          color: Colors.white, 
            child: BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('') : appBar(state);
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
      ),
        body: SingleChildScrollView(
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 50
                ),
                child: Text('Статистика задач',
                  style: TextStyle(
                    fontSize: staticaZadach,
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
                    fontSize: analitika,
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
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Статистика за неделю',
                        style: TextStyle(
                          fontSize: staticDay,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                        SizedBox(width: sizedBox),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                        borderRadius: BorderRadius.circular(2)
                                      ))
                                  ),
                                    onPressed: () {}, 
                                      child: Text('Неделя',
                                      softWrap: false,
                                        style: TextStyle(
                                          fontSize: dayContainerText,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]
                                        ),
                                      )
                                ),
                              ),
                              SizedBox(
                                width: 5,
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
                                        borderRadius: BorderRadius.circular(2)
                                      ))
                                  ),
                                onPressed: () {}, 
                                  child: Text('Месяц',
                                  softWrap: false,
                                    style: TextStyle(
                                      fontSize: dayContainerText,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]
                                    ),
                                  )
                                ),
                            ),
                              SizedBox(
                                width: 5,
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
                                        borderRadius: BorderRadius.circular(2)
                                      ))
                                  ),
                                    onPressed: () {}, 
                                      child: Text('Год',
                                      softWrap: false,
                                        style: TextStyle(
                                          fontSize: dayContainerText,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]
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
              BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('Произошла ошибка загрузки') : statistickContainer(state);
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
                          ),
                          BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('Произошла ошибка загрузки') : diagram(state);
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
                          ),
                          BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('Произошла ошибка загрузки') : diagramTwo(state);
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
                          ),
            ],
        ),
        ),
    );
  }
    Widget appBar (TodoLoaded state) {
      final todos = state.todos;
      return AppBarWidget(
      );
    }

    Widget statistickContainer (TodoLoaded state) {
      final todos = state.todos;
      return StatistickContainersWidget(
      );
    }

    Widget diagram (TodoLoaded state) {
      final todos = state.todos;
      return DiagramWidget();
    }

    Widget diagramTwo (TodoLoaded state) {
      final todos =  state.todos;
      return DiagramTwoWidget();
    }
}