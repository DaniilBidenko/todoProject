import 'package:flutter/widgets.dart';
import 'package:to_do/data/model/todo.dart';

class EditTodoScreen extends StatefulWidget{
  final Todo todo;
  EditTodoScreen({Key? key, required this.todo}) : super (key: key) 
  
  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  
}