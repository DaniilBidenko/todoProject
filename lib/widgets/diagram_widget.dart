import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';

class DiagramWidget extends StatefulWidget{
  DiagramWidget({Key? key}) : super (key: key);
  @override
  _DiagramWidgetState createState() => _DiagramWidgetState();
}

class _DiagramWidgetState extends State<DiagramWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double diadramContainerWidth = width * 0.447;
    double height = MediaQuery.of(context).size.height;
    double diagramContainerHeight = height * 0.5;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 50
                    ),
                      child: Container(
                        color: Colors.white,
                        height: diagramContainerHeight,
                        width: diadramContainerWidth,
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
                  );
  }

  Widget getDiagrammStatistick (TodoLoaded state) {
  final todos =  state.todos;
  double width = MediaQuery.of(context).size.width;
  double raspredelenie = width * 0.013;
  double containerVipolneno = width * 0.02;
  double sizedBoxWidth = width * 0.1;
  double height = MediaQuery.of(context).size.height;
  double containerVipolnenoHeight = height * 0.023;
  double sizedBoxHeight = height * 0.5;
 
  return Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: 0
            ),
              child: Container(
                color: Colors.white,
                // height: 200,
                // width: 200,
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
                              fontSize: raspredelenie
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
                                    height: containerVipolnenoHeight,
                                    width: containerVipolneno,
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
                                        height: containerVipolnenoHeight,
                                        width: containerVipolneno,
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
                              height: sizedBoxHeight,
                              width: sizedBoxWidth,
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
                                        ),
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