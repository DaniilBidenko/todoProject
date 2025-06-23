import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';


class StatistickContainersWidget extends StatefulWidget{
  StatistickContainersWidget({Key? key,}) :super (key: key);
  @override
  _StatistickContainersWidgetState createState() => _StatistickContainersWidgetState();
}

class  _StatistickContainersWidgetState extends State<StatistickContainersWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containersSize = width * 0.175;
    double height = MediaQuery.of(context).size.height;
    double containerHeight = height * 0.10;
               return Padding(
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
                            height: containerHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : statistickContainers(state, 'Всего задач', '${state.todos.length}', Icons.event, Colors.blueAccent);
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
                              height: containerHeight,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                                child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : statistickContainers(state, 'Выполнено', '${state.todos.where((todos) => todos.isCompleted).length}', Icons.task_alt, Colors.greenAccent);
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
                                height: containerHeight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                               child: Row(

                               ),
                              ),
                                Container(
                                  width: containersSize,
                                  height: containerHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                     child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : statistickContainers(state, 'Эффективность', '${((state.todos.where((todos) => todos.isCompleted).length / state.todos.length)* 100).toInt()}%', Icons.show_chart, Colors.orangeAccent);
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
                        ],
                    ),
                );
  }
 Widget statistickContainers (TodoLoaded state, String name, String value, IconData icon, Color iconColor) {
        double width = MediaQuery.of(context).size.width;
          double vsegoZadach = width * 0.01;
          double containersSize = width * 0.1;
          double iconSize = width * 0.04;
          final todos = state.todos;
                   return  Container(                      
                      width: containersSize,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                                left: 10,
                                bottom: 5
                              ),
                                child: Icon(
                                  icon,
                                  size: iconSize,
                                  color: iconColor,
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                              top: 15,
                              left: 10,

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  left: 0,
                                  bottom: 0,
                                ),
                                  child: Text(name,
                                    style: TextStyle(
                                      fontSize: vsegoZadach,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey
                                    ),
                                  ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  left: 0
                                ),
                                  child: Text(value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                            ),
                                ],
                              ),
                            ), 
                          ],
                        ),
                    );            
    }
}