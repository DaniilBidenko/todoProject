import 'package:equatable/equatable.dart';
import 'package:to_do/data/model/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object> get props => [];
}

class LoadTodo extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo (this.todo);
  @override
  List<Object> get props => [
    todo
  ];
}

class ToggleTodoStatus extends TodoEvent {
  final String id;
  const ToggleTodoStatus(this.id);
  @override
  List<Object> get props => [
    id
  ];
}

class EditTodo extends TodoEvent {
  
  final Todo todo;
  const EditTodo(this.todo);
  @override
  List<Object> get props => [
    todo
  ];
}

class DeleteTodo extends TodoEvent{
  final String id;
  const DeleteTodo(this.id);
  @override
  List<Object> get props => [
    id
  ];
}


