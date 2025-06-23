
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/widgets/app_bar_widget.dart';
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
    final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final double baseSize = width < 400 ? 12 : 14;
  final double iconSize = width < 400 ? 16 : 20;
    
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
                                return appBar(state);
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
                    fontSize: baseSize + 5,
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
                    fontSize: baseSize - 3,
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
                          fontSize: baseSize - 3,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                        SizedBox(width: baseSize ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: baseSize + 30 ,
                                height: 40,
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
                                        style: TextStyle(
                                          fontSize: 20,
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
                              width: baseSize + 30,
                              height: 40,
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
                                    style: TextStyle(
                                      fontSize: 20,
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
                              width: baseSize + 30,
                              height: 40,
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
                                        style: TextStyle(
                                          fontSize: 20 ,
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
                          // BlocBuilder<TodoBloc, TodoState>(
                          //   builder: (context, state) {
                          //     if (state is TodoLoading) {
                          //       return CircularProgressIndicator();
                          //     } else if (state is TodoLoaded) {
                          //       return state.todos.isEmpty ? Text('Произошла ошибка загрузки') : diagramTwo(state);
                          //     } else if (state is TodoError) {
                          //       return Center(
                          //         child: Text('ошибка загрузки'),
                          //       );
                          //     } else {
                          //       return const Center(
                          //         child: Text('Все пошло по бороде'),
                          //       );
                          //     }
                          //   }
                          // ),
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

    // Widget diagramTwo (TodoLoaded state) {
    //   final todos =  state.todos;
    //   return DiagramTwoWidget();
    // }
}