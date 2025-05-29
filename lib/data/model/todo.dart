import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
// Создаем модель Todo
class Todo extends Equatable {
  final String name;
  final String id;
  // final String title;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;
  final bool isEditing;
  final bool editAt;
  final String valueDropDown;
  // Делаем конструктор этого класса
  Todo({
    required this.name,
    String? id,
    // required this.title,
    this.description = '',
    DateTime? createdAt,
    this.isCompleted = false,
    required this.isEditing,
    bool? editAt,
    required this.valueDropDown
  }) : 
  id = id ?? const Uuid().v4(),// если у нас есть id то используем его а если нет то генерируем его
   createdAt = createdAt ?? DateTime.now(),
   editAt = editAt ?? false;// если у нас есть createdAt то используем его а если нету то получаем настоящее время
// Применяем новую функцию copyWith
  
  Todo copyWith({
    String? name,
    // String? title,
    String? description,
    bool? isCompleted,
    bool? isEditing,
    bool? editAt,
    DateTime? createdAt,
    String? valueDropDown
  }) {
    return Todo(
      name: name ?? this.name,
      id: id,
      // title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ,
      isCompleted: isCompleted ?? this.isCompleted ,
      isEditing: isEditing ?? this.isEditing,
      editAt: editAt ?? this.editAt,
      valueDropDown: valueDropDown ?? valueDropDown!,
    );
  }
// Закидываем все данные в Json
  Map<String, dynamic> toJson () {
    return {
      'name': name,
      'id': id,
      // 'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(), // формат времени
      'isCompleted': isCompleted,
      'isEditing': isEditing,
      'editAt': editAt,
      'dropDown': valueDropDown
    };
  }
  //Обращаемся к ним из Jsona
  static Todo fromJson (Map<String, dynamic> json) {
    return Todo(
      name: json['name'] as String,
      id: json['id'] as String,
      // title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: json['isCompleted'] as bool,
      isEditing: json['isEditing'] as bool,
      editAt: json['editAt'] as bool,
      valueDropDown: json['valueDropDown'] as String
    );
  }

  @override
  List<Object?> get props => [
    name,
    id,
    // title,
    description,
    createdAt,
    isCompleted,
    isEditing,
    editAt,
    valueDropDown
  ];
}