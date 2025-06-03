
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
    return Container(
      margin: EdgeInsets.symmetric( // внешних отступ
         horizontal: 24,
        vertical: 8
         ),
      width: 40,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border(
          left: BorderSide(
            color: Colors.green,
            width: 4
          )
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Card(
         // создаем нашу карточку задачи
      margin: EdgeInsets.symmetric( // внешних отступ
         horizontal: 0,
        vertical: 0
         ),
       child: Padding(
        padding: EdgeInsets.all(16), // отступ со всех сторон
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              shape: CircleBorder(),
              value: widget.todo.isCompleted, // берем данные нашей модели 
              onChanged: (_) {
                context.read<TodoBloc>().add(ToggleTodoStatus(widget.todo.id)); //   отправляем событие в блок для изменения статуса задачи
              },
              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return todoColor.iconTaskColor; 
    }
    return todoColor.iconTaskColor; 
  }),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.todo.name,
                      style: TextStyle(
                        color: todoColor.titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null,
                       // если задача выполнена то зачернки линией текст иначе ничего
                    ),
                    ),
                    
                    if (widget.todo.description.isNotEmpty) 
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(widget.todo.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: todoColor.descriptionColor,
                          decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена зачеркни описание линией иначе ничего
                        ),
                        ),
                        ),
                        ]
                      )
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                            widget.todo.valueDropDown,
                            style: TextStyle(
                              color: changePriorityColor(widget.todo.valueDropDown),
                              // decoration: todo.valueDropDown ? TextDecoration.lineThrough : null
                              ),
                          ),
                          ElevatedButton(
                           onPressed: _loadColors,
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              textStyle: TextStyle(fontSize: 12), 
                              minimumSize: Size.zero, 
                              ),
                          child: Text('Применить настройки',
                          style: TextStyle(
                            color: Colors.black
                          ),),
                          ),
                                ]
                              )
                              ),
                            SizedBox(
                              width: 25
                            ),
                            Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(' ${DateFormat('yyyy-MM-dd').format(widget.todo.createdAt)}', // обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 10,
                          color: todoColor.createdData,
                          decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ),
                        ),
                        
                        Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: widget.todo.editAt 
                        ? Text(' ${DateFormat('yyyy-MM-dd').format(DateTime.now())}' ,// обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 10,
                          color: todoColor.createdData,
                          decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ) : null
                        ),
                        ],
                      )
                      ),
                      SizedBox(
                        width: 15,
                      ),
                            IconButton(
                        padding: EdgeInsets.all(2),
                        constraints: BoxConstraints(),
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(widget.todo.id)); // отправляем событие в блок для уделания задачи
                        }, 
                        icon: Icon(Icons.delete_forever_outlined, size: 20, color: todoColor.iconDeleteColor,), // значок удаления
                        ),
                        IconButton(
                          padding: EdgeInsets.all(2),
                          constraints: BoxConstraints(),
                          onPressed: 
                           () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditTodoScreen(todo: widget.todo)
                              ));
                          }, 
                          icon: Icon(Icons.edit_document, size: 20, color: todoColor.iconTaskColor,))
                          ],
                        )
                        ),                                             
                  ],
                )
                )
          ],
        ),
        ),
    ),
    );
  }
}
  




