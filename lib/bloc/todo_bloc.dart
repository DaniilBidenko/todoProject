import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/bloc/todo_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/data/repository/todo_repository.dart';
import 'package:to_do/screens/add_todo_screen.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> { // создаем класс TodoBloc с расширениями TodoEvent и TodoState
   final TodoRepository repository; // Создаем нашу переменную с классом TodoRepository

  TodoBloc({required this.repository}) : super(TodoLoading()) { // Создаем события нашего блока
    on<LoadTodo>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<ToggleTodoStatus>(_onToggleTodoStatus);
    on<DeleteTodo>(_onDeleteTodo);
    on<EditTodo>(_onEditTodo);
  }
  
  Future<void> _onLoadTodos (LoadTodo event, Emitter<TodoState> emit) async{ // функция загрузки списка задач
    emit(TodoLoading()); // вызываем событие TodoLoading
    try {
      final todos = await repository.getAllTodos(); // в переменной todos ждем получения списка задач
      emit(TodoLoaded(todos)); // вызываем событие TodoLoaded с нашим списком задач
    } catch (e) { // иначе получаем ошибку 
      emit(TodoError('Ошибочка загрузки ${e.toString()}'));
    }
  }

  Future<void> _onAddTodo (AddTodo event, Emitter<TodoState> emit) async{ // создаем функцию добавления списка задач
    try {
      if (state is TodoLoaded) { // если состояние это TodoLoaded
        final currentState = (state as TodoLoaded).todos; // создаем переменную c текущим состоянием
        await repository.addTodo(event.todo); // ждем добавление задач в список задач
        final updatedTodos = await repository.getAllTodos(); // создаем переменную в которой будем ждать получение обновленного списка задач
        emit(TodoLoaded(updatedTodos)); // вызываем TodoLoaded c обновленным списком задач
      }
    } catch (e) { // иначе получаем ошибку добавления
      emit(TodoError('Ошибка добавления ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTodo (DeleteTodo event, Emitter<TodoState> emit) async{ // создаем функцию удаления задач 
    try {
      if (state is TodoLoaded) { // если состояние это TodoLoaded
        await repository.deleteTodo(event.id); // ждем наш список задач и удаляем задачу с выбранным id
        final updatedTodos = await repository.getAllTodos(); // удалили, теперь удаляем , делаем переменую в которой будем ждать получения уже обновленного списка задач
        emit(TodoLoaded(updatedTodos)); // вызывает состояние TodoLoaded c обновленным списком задач
      }
    } catch (e) { // при неудаче получаем ошиббку удаления
      emit(TodoError('Ошибка удаления ${e.toString()}'));
    }
  }

  Future<void> _onToggleTodoStatus (ToggleTodoStatus event, Emitter<TodoState> emit) async{ // создаем функцию обновления списка задач
    try {
      if (state is TodoLoaded) { // если состояние TodoLoaded
        await repository.toggleTodoStatus(event.id); // ждем получения списка задач с нужным id 
        final updatedTodos = await repository.getAllTodos(); // создаем переменную в которой будем ждать получения нашего списка задач
        emit(TodoLoaded(updatedTodos)); // вызываем событие TodoLoaded c  обновленым списком задач
      }
    } catch (e) { // иначе получаем ошибку обновления
      emit(TodoError('Ошибка обновления ${e.toString()}'));
    }
  }

  Future<void> _onEditTodo (EditTodo event, Emitter<TodoState> emit) async{
   try {
      if (state is TodoLoaded) {
        await repository.editTodo(event.todo);
        final updateTodos = await repository.getAllTodos();
        emit(TodoLoaded(updateTodos));
      }
    } catch (e) {
      emit(TodoError('Ошибка изменения ${e.toString()}'));
    }
  }

  
}