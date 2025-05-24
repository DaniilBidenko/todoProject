import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/model/todo.dart';

class EditTodoScreen extends StatefulWidget{
  final Todo todo;
  
  EditTodoScreen({Key? key, required this.todo}) : super (key: key) ;
  
  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? header;
  String? description;
  String? name;
  DateTime? _editTime;
  String? formatDate;
  
  
  
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(text: widget.todo.description);
    _nameController = TextEditingController(text: widget.todo.name);
    _editTime = widget.todo.createdAt;
    formatDate = DateFormat('yyyy-MM-dd-kk:mm').format(_editTime!);
  }

  @override
  void dispose () {
    _titleController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double myFontSize = width * 0.018;
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование задач'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите имя пользователя';
                  }
                  return null;
                },
                onSaved: (value) => name = value,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox (
                height: 16
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите заголовок';
                  } 
                  return null;
                },
                onSaved: (value) => header = value,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Заголовок',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите описание';
                  }
                  return null;
                },
                onSaved: (value) => description = value,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              // height: height * 0.07,
              width: width * 0.98,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade600
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: Text(
                _editTime == null ? 'Выберите дату' :  DateFormat('yyyy-MM-dd -kk:mm').format(_editTime!),
                style: TextStyle(
                  color: Colors.grey.shade700,
                fontSize: myFontSize,
                fontWeight: FontWeight.normal
                )
                ),
              ),
             ),
              SizedBox(
                height: 16,
              ),
            //   Container(
            //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            //   // height: height * 0.07,
            //   width: width * 0.98,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 1,
            //       color: Colors.grey.shade600
            //     ),
            //     borderRadius: BorderRadius.all(Radius.circular(5)),
            //   ),
            //   child: GestureDetector(
            //     onTap: () => _editDate(context),
            //     child: Text(
            //     _dateTime == null ? 'Дата редактирования' : _dateTime.toString(),
            //     style: TextStyle(
            //       color: Colors.grey.shade700,
            //     fontSize: myFontSize,
            //     fontWeight: FontWeight.normal
            //     )
            //     ),
            //   ),
            //  ),
             SizedBox(
              height: 50,
             ),
              ElevatedButton(
                onPressed: _updateTodo,
                child: Text('Сохранить изменения'))
            ],
          )
          ),
      ),
    );
  }
  void _updateTodo () {
    if (_formKey.currentState!.validate()) {
      final updateTodo = widget.todo.copyWith(title: _titleController.text, description: _descriptionController.text, name: _nameController.text, createdAt: _editTime, editAt: true);
      context.read<TodoBloc>().add(EditTodo(updateTodo));
      Navigator.pop(context);
    }
  }

  Future _selectDate (BuildContext context) async{
     DateTime? editTime = await showDatePicker(
      context: context, 
      initialDate: _editTime ?? DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101));
      if (editTime != null && editTime != _editTime) {
        setState(() {
          _editTime = editTime;
        });
        print(editTime);
      } 
}

// Future _editDate (BuildContext context) async{
//      DateTime? dateTime = await showDatePicker(
//       context: context, 
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000), 
//       lastDate: DateTime(2101));
//       if (dateTime != null && dateTime != _dateTime) {
//         setState(() {
//           _dateTime = dateTime;
//         });
//         print(dateTime);
//       } 
// }

  
}