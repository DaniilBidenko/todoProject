import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/model/todo.dart';

class AddTodoScreen extends StatefulWidget{
  const AddTodoScreen({Key? key}) : super (key: key);
  
   
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState(); // создаем состояние 
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(); // делаем ключ формы
  final _titleController = TextEditingController(); // делаем переменную которую можем использовать только в этом классе и которая будет сохранять текст
  final _descriptionController = TextEditingController();
  DateTime? _dateTime;
  String? header;
 
  
  
  @override
  void dispose () {
    _nameController.dispose(); // функция очистки контроллеров при удалении виджета
    _titleController.dispose(); // эта строчка очищает текст заголовка
    _descriptionController.dispose(); 
    super.dispose();
  }

  

  @override // создаем экран
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double myFontSize = width * 0.018;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление задач'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16), // делаем отступ со всех сторон 16 пикселей
        child: Form( // Form используется для валедации полей 
          key: _formKey, // исользуем наш ключ
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
                onSaved: (value) => header = value,
                 style: TextStyle(
                  fontSize: myFontSize,
                ),
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  border: OutlineInputBorder()
                ),
              ),
              // TextFormField(
              //   autovalidateMode: AutovalidateMode.always,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Пожалуйста введите заголовок';
              //     } 
              //     return null;
              //   },
              //   onSaved: (value) => header = value,
              //    style: TextStyle(
              //     fontSize: myFontSize,
              //   ),
              //   controller: _titleController, // исользуем нашу переменную для сохранения заголовка
              //   decoration: InputDecoration(
              //     labelText: 'Заголовок',
              //     border: OutlineInputBorder()
              //   ),
              // ),
              SizedBox(
                height: 16, // отступ между элементами
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите описание';
                  } 
                    return null;
                },
                onSaved: (value) => header = value,
                style: TextStyle(
                  fontSize: myFontSize,
                ),
                controller: _descriptionController, // используем нашу переменную для сохранения описания
                decoration: InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 24, // отступ между элементами
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
                _dateTime == null ? 'Выберите дату' :  DateFormat('yyyy-MM-dd').format(_dateTime!),
                style: TextStyle(
                  color: Colors.grey.shade700,
                fontSize: myFontSize,
                fontWeight: FontWeight.normal
                )
                ),
              ),
             ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: _submitForm, 
                child: Padding(
                  padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 3
                  ),
                  child: Text('Добавить задачу',
                  style: TextStyle(
                    fontSize: 16
                  )
                  ),
                  )
                ), SizedBox(
                  height: 24,
                ),
            ],
          )
          ),
        ),
    );
    
  }

  void _submitForm () { 
    if (_formKey.currentState!.validate()) {
       _formKey.currentState!.save();
      final newTodo = Todo(
       name: _nameController.text, // делаем обьект нашего класса Todo
      //  title: _titleController.text, // преобразуем наши переменные в текст
       description: _descriptionController.text,
       createdAt: _dateTime,
       isEditing: false,
      //  dropDown: ['Легкий', 'Средний' , 'Тяжелый']
       );
      context.read<TodoBloc>().add(AddTodo(newTodo)); // отправляем наше событие в блок 
      Navigator.pop(context); // возвращение на предыдущий экран
    } 
   
  }
  
  Future _selectDate (BuildContext context) async{
     DateTime? dateTime = await showDatePicker(
      context: context, 
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101));
      if (dateTime != null && dateTime != _dateTime) {
        setState(() {
          _dateTime = dateTime;
        });
        print(dateTime);
      } 
}

  

 
}