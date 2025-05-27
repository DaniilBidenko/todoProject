
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/screens/edit_todo_screen.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({required this.todo, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(todo.editAt);
    return Container(
      margin: EdgeInsets.symmetric( // внешних отступ
         horizontal: 24,
        vertical: 8
         ),
      width: 40,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
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
              value: todo.isCompleted, // берем данные нашей модели 
              onChanged: (_) {
                context.read<TodoBloc>().add(ToggleTodoStatus(todo.id)); //   отправляем событие в блок для изменения статуса задачи
              }
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
                          Text(todo.name,
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                       // если задача выполнена то зачернки линией текст иначе ничего
                    ),
                    ),
                    if (todo.description.isNotEmpty) 
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(todo.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена зачеркни описание линией иначе ничего
                        ),
                        ),
                        ),
                        ]
                        
                      )
                      ),
                      
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('Дата создания : ${DateFormat('yyyy-MM-dd').format(todo.createdAt)}', // обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ),
                        ),
                        
                        Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: todo.editAt 
                        ? Text('Дата редактирования : ${DateFormat('yyyy-MM-dd').format(DateTime.now())}' ,// обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ) : null
                        ),
                        ],
                      )
                      ),
                      
                      IconButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(todo.id)); // отправляем событие в блок для уделания задачи
                        }, 
                        icon: Icon(Icons.delete_forever_outlined, size: 17,), // значок удаления
                        ),
                        IconButton(
                          onPressed: 
                           () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditTodoScreen(todo: todo)
                              ));
                          }, 
                          icon: Icon(Icons.edit_document, size: 17,))
                        
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


