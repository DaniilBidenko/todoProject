import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:to_do/data/model/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database; // делаем базу данных уникальной
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if(_database != null) { // если база данных не пустая
      return _database!; // возвращаем базу данных
    }
    _database = await _initDataBase(); // ждем инициализации базы данных
    return _database!; 
  }

  Future<Database> _initDataBase () async{  // инициализация базы данных
    String path = join(await getDatabasesPath(), 'todo_database.db'); // указываем путь и название базы данных

    return await openDatabase( // открытие базы данных
      path, // путь
      version: 1, // версия
      onCreate: _createDataBase //создание базы данных
      );
  }

  Future<void> _createDataBase (Database db, int version) async{ // функция создания таблиц базы данных
    await db.execute( // таблица тодо
      '''
      CREATE TABLE todos(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        createdAt TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        isEditing INTEGER NOT NULL,
        editAt INTEGER NOT NULL,
        valueDropDown TEXT NOT NULL,
      )
      '''
    );
    await db.execute( // таблица настройки цветов
      '''
      CREATE TABLE color_settings(
        id INTEGER PRIMARY KEY,
        key TEXT UNIQUE NOT NULL,
        value INTEGER NOT NULL
      )
      '''
    );
  }

  Future<List<Todo>> getAllTodos() async{
    final db = await database; // ждем получения базы данных
    final List<Map<String, dynamic>> maps = await db.query('todos'); //делаем переменную которая вернет нам список списка обьектов таблицы тодо

    return List.generate(maps.length, (i) { // генерируем список длинной списка обьектов тодо по айди
      return Todo(
        id: maps[i]['id'],
        name: maps[i]['name'], 
        description: maps[i]['descriprion'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        isCompleted: maps[i]['isCompleted'] == 1, // is bool
        isEditing: maps[i]['isEditing'] == 1, 
        editAt: maps[i]['editAt'] == 1,
        valueDropDown: maps[i]['valueDropDown']
        );
      
    });
  }

  Future<void> insertTodo (Todo todo) async{ // добавляем новые задачи
    final db = await database; // получаем базу данных

    await db.insert('todos', { // добавляем в базу данных таблицу todos
      'id': todo.id,
      'name': todo.name,
      'description': todo.description,
      'createdAT': todo.createdAt.toIso8601String(), // превращаем в формат времени
      'isCompleted': todo.isCompleted ? 1 : 0, // превращаем в int
      'isEditing': todo.isEditing ? 1 : 0,
      'editAt': todo.editAt ? 1 : 0,
      'valueDropDown': todo.valueDropDown
    },
    conflictAlgorithm: ConflictAlgorithm.replace // заменить одинаковые элементы при повторе id
    );
  }

  Future<void> updateTodo (Todo todo) async{ // функция обновленных данных тодо
    final db = await database; // получаем базу данных

    await db.update('todos', { // обновленные данные таблицы todos
        'id': todo.id,
        'name': todo.name,
        'description': todo.description,
        'createdAt': todo.createdAt.toIso8601String(), // превращаем в формат времени
        'isCompleted': todo.isCompleted ? 1 : 0, // превращаем в Int
        'isEditing': todo.isEditing ? 1 : 0,
        'editAt': todo.editAt ? 1 : 0,
        'valueDropDown': todo.valueDropDown
      },
      where: 'id = ?', // условие по айди
      whereArgs: [todo.id] // сравниваем условие с списком
    );
  }

  Future<void> deleteTodo (String id) async{ // функция удаления 
    final db = await database; // получаем базу данных

    await db.delete('todos', // удаляем задачу по айди
        where: 'id = ?', // задаем условие
        whereArgs: [id] // сравниваем с условием
      );
    }

   Future<void> editTodo(Todo todo) async {
    final db = await database;
    
    // Обновляем запись в таблице todos по ID
    await db.update(
      'todos',
      {
        'name': todo.name,                                    // Новое название
        'description': todo.description,                      // Новое описание
        'createdAt': todo.createdAt.toIso8601String(),        // Дата (обычно не меняется)
        'isCompleted': todo.isCompleted ? 1 : 0,              // Новый статус выполнения
        'isEditing': todo.isEditing ? 1 : 0,                  // Режим редактирования
        'editAt': todo.editAt ? 1 : 0,                        // Флаг редактирования
        'valueDropDown': todo.valueDropDown,                  // Значение dropdown
      },
      where: 'id = ?',        // Условие: обновляем только запись с указанным ID
      whereArgs: [todo.id],   // Параметр для условия WHERE
    );
  }



  Future<int?> getColorSettings (String key) async{ // функция получения цветов
    final db = await database; // получаем базу данных

    final List<Map<String, dynamic>> maps = await db.query('color_settings', where: 'key = ?', whereArgs: [key]); // получение базы данных таблицы найтроки цветов с условием по ключу
    if (maps.isNotEmpty) { // если список не пустой
      return maps.first['value'] as int; // вернуть первый элемент списка поля value как int 
    } 
    return null; // иначе вернуть ничего
  }

  Future<void> setColorSettings (String key, int value) async{ // функция загрузки цветов
    final db = await database; // получаем базу данных

    await db.insert('color_settings', { // загружаем цвета
      'key': key,
      'value': value,
    },
    conflictAlgorithm: ConflictAlgorithm.replace // заменить одинаковые элементы при повторе ключа
    );
  }
   
    Future<void> deleteColorSettings (String key) async{ // функция удаления цветов
      final db = await database; // получаем базу данных

      await db.delete('color_settings', // удаляем цвета по ключу
      where: 'key = ?',
      whereArgs: [key]
      );
    }

    Future<void> close () async{ // функция закрытия базы данных
      final db = await database; // получаем базу данных

      await db.close(); // закрываем базу данных
    } 
}