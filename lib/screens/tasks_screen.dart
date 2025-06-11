import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/widgets/app_bar_widget.dart';
import 'package:to_do/widgets/new_todo_item.dart';

Color changePriorityColor (String priorityValue) {
  switch (priorityValue) {
    case 'Низкий' :
      return Colors.lightBlue;
    case 'Средний' : 
      return Colors.orangeAccent;
    case 'Высокий' : 
      return Colors.redAccent;
    default :
      return Colors.black;
  } 
 }

class TasksScreen extends StatefulWidget{ 
  final Todo? todo;
  const TasksScreen({Key? key, this.todo}) : super(key: key); 
  @override
  _TaskscreenState createState() => _TaskscreenState();
}

class _TaskscreenState extends State<TasksScreen> {
  Key _listKey = UniqueKey();
  late AppBarColors appBarColors;
  late TodoColor todoColor;
  @override
  void initState() {
    super.initState();
    appBarColors = AppBarColors();
    todoColor = TodoColor();
    _loadColors();
  }

  Future<void> _loadColors() async{
    final colors = await AppBarColors.loadFromPrefs();
    final newColor = await TodoColor.loadFromPrefs();
    setState(() {
      appBarColors = colors;
      todoColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: BlocBuilder<TodoBloc, TodoState>(
                            builder: (context, state) {
                              if (state is TodoLoading) {
                                return CircularProgressIndicator();
                              } else if (state is TodoLoaded) {
                                return state.todos.isEmpty ? Text('Произошла ошибка загрузки') : appBar(state);
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
        )
        ),
          body: RefreshIndicator(
            child: BlocBuilder<TodoBloc, TodoState>( // создаем BlocBuilder c расширениями TodoBloc и TodoState
              builder: (context, state) {
                if (state is TodoLoading) { // если состояние TodoLoading 
                    return Center(
                            child: CircularProgressIndicator(), // то по центру мы запускаем вращающийся кружок
                    );
                } else if (state is TodoLoaded) { // если состояние TodoLoaded
                    return state.todos.isEmpty ? _buildEmptyState() : _buildTodoList(state); // возвращаем , если список пустой, говорим что задач пока нет иначе отображаем список задач
                  } else if (state is TodoError) { // если состояние TodoError
                    return Center(
                      child: Text('Ошибка загрузки'), // то возвращаем сообщение 
                    );
                    }   else {
                          return const Center(
                          child: Text('Все пошло по бороде'),
                            );
                          } 
                }
              ),
                onRefresh: () async{
                  return Future<void>.delayed(const Duration(seconds: 3));
                  })
      );
    }
  Widget _buildEmptyState () { // создаем виджет пустого состояния
    return Center(
      child: Text('Задач пока нет'),
    );
  }
 
  Widget _buildTodoList (TodoLoaded state) { // создаем виджет с параметром Todoloaded state
    final todos = state.todos; // создаем переменную в которой будет список задач
    return ListView.builder(
      key: _listKey, // создаем прокручиваемый массив
      itemCount: todos.length, // с числом строк равным длиннной нашего списка задач
      itemBuilder: (context , index) { // itemBuilder с параметрами context и index
        return TodoItem(
          todo: todos[index],
          key: ValueKey('todo_${todos[index].id}_${DateTime.now().millisecondsSinceEpoch}'),
           // говорим что будет отображаться список задач по его indexy
        );
      }
      );
  }

   Widget appBar (TodoLoaded state) {
      final todos = state.todos;
      return AppBarWidget(
      );
    }
  }
