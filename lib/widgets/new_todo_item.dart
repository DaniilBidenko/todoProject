
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/edit_todo_screen.dart';

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

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({required this.todo, Key? key}) : super(key: key);
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TodoColor todoColor;
  @override
  void initState() {
    super.initState();
    todoColor = TodoColor();
    _loadColors();
  }

  Future<void> _loadColors() async{
    final colors = await TodoColor.loadFromPrefs();
    setState(() {
      todoColor = colors;
    });
  }

  @override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  final double baseSize = width < 400 ? 12 : 14;
  final double iconSize = width < 400 ? 16 : 20;

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        left: BorderSide(color: Colors.green, width: 4),
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black12)],
    ),
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 0,
              bottom: 15
            ),
            child: Checkbox(
            shape: const CircleBorder(),
            value: widget.todo.isCompleted,
            onChanged: (_) {
              context.read<TodoBloc>().add(ToggleTodoStatus(widget.todo.id));
            },
            fillColor: MaterialStateProperty.all(todoColor.iconTaskColor),
          ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.todo.name,
                  style: TextStyle(
                    fontSize: baseSize + 1,
                    fontWeight: FontWeight.w600,
                    color: todoColor.titleColor,
                    decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (widget.todo.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(widget.todo.description,
                      style: TextStyle(
                        fontSize: baseSize,
                        color: todoColor.descriptionColor,
                        decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 50
            ),
                child: Text(widget.todo.valueDropDown,
                  style: TextStyle(
                    fontSize: baseSize,
                    color: changePriorityColor(widget.todo.valueDropDown),
                  )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Padding(
                  padding: const EdgeInsets.only(top: 4, left: 15),
                  child: Text(
                    'Создано: ${DateFormat('yyyy-MM-dd').format(widget.todo.createdAt)}',
                    style: TextStyle(
                      fontSize: baseSize - 5,
                      color: todoColor.createdData,
                      decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                if (widget.todo.editAt)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 30),
                    child: Text(
                      'Изменено: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: baseSize - 5,
                        color: todoColor.createdData,
                        decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null
                      ),
                    ),
                  ),
                ],
              )
            ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(
                    left: 0
                  ),
                    child:  IconButton(
                      padding: EdgeInsets.all(2),
                    icon: Icon(Icons.delete_forever_outlined, color: todoColor.iconDeleteColor, size: 20),
                    onPressed: () => context.read<TodoBloc>().add(DeleteTodo(widget.todo.id)),
                    constraints: BoxConstraints(),
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(
                    left: 0
                  ),
                    child: IconButton(
                    padding: EdgeInsets.all(2),
                    icon: Icon(Icons.edit_document, color: todoColor.iconTaskColor, size: 20),
                    constraints: BoxConstraints(
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditTodoScreen(todo: widget.todo),
                      ));
                    },
                  ),
                  )
                  ]
                )
                )
                  
                  
        ],
      ),
    ),
  );
}
  }

  




