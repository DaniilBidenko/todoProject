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
    return Card( // создаем нашу карточку задачи
      margin: EdgeInsets.symmetric( // внешних отступ
        horizontal: 16,
        vertical: 8
        ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 50,
              right: 50,
              child: Container(
                color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Row(
                  children: [
                    Positioned(
                      child: Checkbox(
                        value: todo.isCompleted, // берем данные нашей модели 
                        onChanged: (_) {
                        context.read<TodoBloc>().add(ToggleTodoStatus(todo.id)); //   отправляем событие в блок для изменения статуса задачи
                        }   
                      ),
                    ),
                    Positioned(
                      child: Text(todo.name,
                      style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                       // если задача выполнена то зачернки линией текст иначе ничего
                    ),
                    ),
                      ),
                    Positioned(
                      child: Text(todo.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена зачеркни описание линией иначе ничего
                        ),
                        ),
                        
                      ),
                    Positioned(
                        child: Text('Дата создания : ${DateFormat('yyyy-MM-dd -kk:mm').format(todo.createdAt)}', // обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ),
                        ),
                      Positioned(
                          child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: todo.editAt 
                        ? Text('Дата редактирования : ${DateFormat('yyyy-MM-dd -kk:mm').format(DateTime.now())}' ,// обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ) : null
                        ),
                          ),
                      Positioned(
                        child: IconButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(todo.id)); // отправляем событие в блок для уделания задачи
                        }, 
                        icon: Icon(Icons.delete), // значок удаления
                        ),
                        ), 
                        Positioned(
                          child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EditTodoScreen(todo: todo)
                              ));
                          }, 
                          child: Text(
                            'Изменить задачу'
                          )
                          )
                          ) 
                  ],
                ),
              )
              )
          ],
        )
        )
    );
  }
}