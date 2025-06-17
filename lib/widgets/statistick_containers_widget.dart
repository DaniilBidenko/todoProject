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
     final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final double baseSize = width < 400 ? 12 : 14;
  final double iconSize = width < 400 ? 16 : 20;
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
                            width: baseSize,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : getListTodo(state);
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
                              width: baseSize,
                              height: 40,
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
                                width: baseSize,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                               child: Row(

                               ),
                              ),
                                Container(
                                  width: baseSize,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                     child: BlocBuilder<TodoBloc, TodoState>(
                                  builder: (context, state) {
                                    if (state is TodoLoading) {
                                      return CircularProgressIndicator();
                                    } else if (state is TodoLoaded) {
                                      return state.todos.isEmpty ? Text('У вас недостаточно информации для выведения статистики') : getEffectivTodo(state);
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

  Widget getListTodo (TodoLoaded state) {
          final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final double baseSize = width < 400 ? 12 : 14;
  final double iconSize = width < 400 ? 16 : 20;
          final todos = state.todos;
            return Container(                      
                      width: baseSize,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0,
                                left: 10
                              ),
                                child: Icon(
                                  Icons.event,
                                  size: iconSize,
                                  color: Colors.blue,
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                              top: 24,
                              left: 10
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
                                  child: Text('Всего задач',
                                    style: TextStyle(
                                      fontSize: baseSize,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                  left: 0
                                ),
                                  child: Text('${todos.length}',
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

 Widget getCompletedListTodo (TodoLoaded state) {
  final todos = state.todos;
   final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final double baseSize = width < 400 ? 12 : 14;
  final double iconSize = width < 400 ? 16 : 20;
  return Container(                      
            width: baseSize,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
              child: Row (
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10
                    ),
                      child: Icon(
                        Icons.task_alt,
                        size: iconSize,
                        color: Colors.green,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 26,
                      left: 10
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Выполнено задач ',
                  style: TextStyle(
                    fontSize: baseSize,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  Text(' ${todos.where((todos) => todos.isCompleted).length}',
                  style: TextStyle(
                  fontSize: baseSize,
                  fontWeight: FontWeight.bold
                    ),
                  )
                      ],
                    )
                    ),
                ]
              ),
              );
 }

 Widget getEffectivTodo (TodoLoaded state) {
      final todos = state.todos;
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;

      final double baseSize = width < 400 ? 12 : 14;
      final double iconSize = width < 400 ? 16 : 20;
        return Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0,
                  left: 25,
                  bottom: 0,
                  right: 0
                ),
                child: Row (
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                    ),
                      child: Icon(
                        Icons.show_chart,
                        size: iconSize,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 26,
                      left: 10
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Эффективность :',
                  style: TextStyle(
                    fontSize: baseSize ,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  Text('${((todos.where((todos) => todos.isCompleted).length / todos.length)* 100).toInt()}%',
                  style: TextStyle(
                  fontSize: baseSize,
                  fontWeight: FontWeight.bold
                    ),
                  ),
                      ],
                    )
                    ),
                ]
              ),
              ),
        );
    }

  Widget getDiagrammStatistick (TodoLoaded state) {
  final todos =  state.todos;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final double baseSize = width < 400 ? 12 : 14;
    final double iconSize = width < 400 ? 16 : 20;
  return Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: 0
            ),
              child: Container(
                color: Colors.white,
                height: 200,
                width: 200,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 30
                            ),
                            child: Text('Распределение по статусу',
                            style: TextStyle(
                              fontSize: baseSize
                            ),
                          ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 50
                            ),
                            child: Expanded(
                            child: Row(
                              children: [
                                Container(
                                  child: Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Выполнено')
                              ],
                            )
                            ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                left: 50
                              ),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Container(
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text('В процессе')
                                  ],
                                ),
                              ),
                            )
                          
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                             SizedBox(
                              height: 360,
                              width: 170,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value: todos.length.toDouble() - todos.where((todos) => todos.isCompleted).length.toDouble(),
                                        color: Colors.orange,
                                        radius: 20,
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.orange.shade800
                                        )
                                      ),
                                        PieChartSectionData(
                                          value: todos.where((todos) => todos.isCompleted).length.toDouble(),
                                          color: Colors.green,
                                          radius: 20,
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.green.shade800
                                          )
                                        )
                                    ],
                                    sectionsSpace: 5,
                                    centerSpaceRadius: 60,
                                )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              ),
          );
    }
}