import 'package:to_do/data/database/database_helper.dart';
import 'package:to_do/data/model/todo.dart';

// Создаем класс репозитори
class TodoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Todo>> getAllTodos () async{
    return await _databaseHelper.getAllTodos();
  }

  Future<void> addTodo (Todo todo) async{
    await _databaseHelper.insertTodo(todo);
  }

  Future<void> deleteTodo (String id) async{
    await _databaseHelper.deleteTodo(id);
  }

  Future<void> toggleTodoStatus (String id) async{
    final todos = await _databaseHelper.getAllTodos();
    final todo = todos.firstWhere((todo) => todo.id == id);
    final updatetodo = todo.copyWith(isCompleted: !todo.isCompleted);

    await _databaseHelper.updateTodo(updatetodo);
  }

  Future<void> editTodo (Todo updateTodo) async{
    await _databaseHelper.editTodo(updateTodo);
  }
}
//   static const String _todosKey = 'todos'; // делаем ключ к нашему локальному хранилищу, _ не позволяепт обращаться к полю вне класса
//   //  получаем все задачи 
//   Future<List<Todo>> getAllTodos () async {
//     final prefs = await SharedPreferences.getInstance (); // инициализация локального хранилища
//     final todosJson = prefs.getStringList(_todosKey) ?? []; // если локальное хранилище с ключом todoskey пустое, вернет пустой массив иначе вернет массив наших задач
    
//     return todosJson.map((todoStr) {
//       final todoMap = jsonDecode(todoStr) as Map<String, dynamic>; // Делаем наш массив как обьект
//       return Todo.fromJson(todoMap); // возвращает новую map при помощи метода класса Todo
//     }).toList();
//   }
// // Добавляем наш todo
//   Future<void> addTodo (Todo todo) async {
//     final prefs = await SharedPreferences.getInstance(); // инициалиpируем запрос на локальное хранилище
//     final todosJson = prefs.getStringList(_todosKey) ?? []; // если локальное хранилище с ключом todoskey пустое, вернет пустой массив иначе вернет массив наших задач
    
//     todosJson.add(jsonEncode(todo.toJson()));  //  мы получаем наши данные в параметр todo, todo превращаем в json а json мы кодируем

//     await prefs.setStringList(_todosKey, todosJson); // сохраняет наше локальное хранилище
//   }
// // удаление todo
//   Future<void> deleteTodo (String id) async {
//    final prefs = await SharedPreferences.getInstance();
//    final todosJson = prefs.getStringList(_todosKey) ?? [];
//    final index = _findTodoIndexById(todosJson, id); // функция поиска id
//   // сравниваем наш поиск и если он равен тому что мы выбрали то удаляем его
//    if (index != -1) { 
//       todosJson.removeAt(index);
//       await prefs.setStringList(_todosKey, todosJson); // обновляем наш список задач
//       }
//   }
// // обновляем наш todo
//   Future<void> toggleTodoStatus (String id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final todosJson = prefs.getStringList(_todosKey) ?? [];
//     final index = _findTodoIndexById(todosJson, id);
//     // использую вспомогательную функцию поиска находим наш айди
//     if (index != -1) {
//       final todoMap = jsonDecode(todosJson[index]) as Map<String, dynamic>;
//       final todo = Todo.fromJson(todoMap);
//       final updateTodo = todo.copyWith(isCompleted: !todo.isCompleted);
//       todosJson[index] = jsonEncode(updateTodo.toJson());
//       await prefs.setStringList(_todosKey, todosJson);
//     }
//   }

//   Future<void> editTodo (Todo updateTodo) async{
//     final prefs = await SharedPreferences.getInstance();
//     final todosJson = prefs.getStringList(_todosKey) ?? [];
//     final index = _findTodoIndexById(todosJson, updateTodo.id);

//     if (index != -1) {
//       todosJson[index] = jsonEncode(updateTodo.toJson());
//       await prefs.setStringList(_todosKey, todosJson);
//     }
//   }

//   int _findTodoIndexById (List<String> todosJson, String id) {
//     for (int i = 0; i < todosJson.length; i++) { // строчка благодаря которой будем проверять каждый элемент списка
//       final todoMap = jsonDecode(todosJson[i]) as Map<String, dynamic>;
//       if (todoMap['id'] == id) { // у нас есть список с индексами если индекс равен тому который мы вписали то возращаем id
//         return i;
//       }
//     }
//     return -1;
//   }
//   }
