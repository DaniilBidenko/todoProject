import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({required this.todo, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card( // создаем нашу карточку задачи
      margin: EdgeInsets.symmetric( // внешних отступ
        horizontal: 16,
        vertical: 8
        ),
      child: Padding(
        padding: EdgeInsets.all(16), // отступ со всех сторон
        child: Row(
          children: [
            Checkbox(
              value: todo.isCompleted, // берем данные нашей модели 
              onChanged: (_) {
                context.read<TodoBloc>().add(ToggleTodoStatus(todo.id)); //   отправляем событие в блок для изменения статуса задачи
              }
              ),
              SizedBox(
                width: 8, // отступ между элементами
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo.name,
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена то зачернки линией текст иначе ничего
                    ),
                    ),
                    Text(todo.title , // обращаемся к модели и выбираем поле title
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена то зачернки линией текст иначе ничего
                    ),
                    ),
                    if (todo.description.isNotEmpty) 
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(todo.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null // если задача выполнена зачеркни описание линией иначе ничего
                        ),
                        ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('Дата создания : ${todo.createdAt}' , // обращаем к классу и выбираем поле дата создания с типом данных DateTime
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
                        ),
                        ),
                        ),
                      IconButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(todo.id)); // отправляем событие в блок для уделания задачи
                        }, 
                        icon: Icon(Icons.delete), // значок удаления
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => 
                              ))
                          
                          }, 
                          child: Text(
                            'Изменить задачу'
                          )
                          )
                  ],
                )
                )
          ],
        ),
        ),
        
    );
    
  }
  }

  
  

  
  
