import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_state.dart';
import 'package:to_do/data/model/todo.dart';
import 'package:to_do/my_color/color.dart';
import 'package:to_do/screens/add_todo_screen.dart';
import 'package:to_do/screens/settings_screen.dart';
import 'package:to_do/widgets/new_todo_item.dart';

class Homescreen extends StatefulWidget{ 
  final Todo todo;

  const Homescreen({Key? key, required this.todo}) : super(key: key); 
  @override

  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late AppBarColors appBarColors;
  late TodoColor todoColors;
  

  @override
  void initState() {
    super.initState();
    appBarColors = AppBarColors();
    todoColors = TodoColor();
    _loadColors();
  }

  Future<void> _loadColors() async{
    final colors = await AppBarColors.loadFromPrefs();
    final newColors = await TodoColor.loadFromPrefs();
    setState(() {
      appBarColors = colors;
      todoColors = newColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Задачник',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color:  appBarColors.titleAppBarColor
        ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SettingsScreen()
              )).then((_) {
                // После возвращения с экрана настроек, перезагружаем цвета
                _loadColors();
              });
          }, 
          child: Text('Настройки',
          style: TextStyle(
            color: appBarColors.buttonSettingsTextColor
          ),
          )),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 3, 32, 248),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        child: ElevatedButton(
         style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 3, 32, 248)),
         ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddTodoScreen()
              ));
          }, 
          child: Text('+ Добавить задачу',
          style: TextStyle(
            color: appBarColors.buttonAddedTextColor
          ),)
          ),
        )
            ]
          ),
            
          ),),
      
      body: BlocBuilder<TodoBloc, TodoState>( // создаем BlocBuilder c расширениями TodoBloc и TodoState
        builder: (context, state) {
          if (state is TodoLoading) { // если состояние TodoLoading 
            return Center(
              child: CircularProgressIndicator(), // то по центру мы запускаем вращающийся кружок
            );
          } else if (state is TodoLoaded) { // если состояние TodoLoaded
            return state.todos.isEmpty ? _buildEmptyState() : _buildTodoList(state); // возвращаем , если список пустой, говорим что задач пока нет иначе отображаем список задач
          } else if (state is TodoError) { // если состояние TodoError
            return Center(
              child: Text('Ошибка загрузки'), // то возвращаем сообщение 
            );
          } else {
            return const Center(
              child: Text('Все пошло по бороде'),
            );
          }
        }
        ),
    );
}

  Widget _buildEmptyState () { // создаем виджет пустого состояния
    return Center(
      child: Text('Задач пока нет'),
    );
  }
 
  Widget _buildTodoList (TodoLoaded state) { // создаем виджет с параметром Todoloaded state
    final todos = state.todos; // создаем переменную в которой будет список задач
    return ListView.builder( // создаем прокручиваемый массив
      itemCount: todos.length, // с числом строк равным длиннной нашего списка задач
      itemBuilder: (context , index) { // itemBuilder с параметрами context и index
        return TodoItem(
          todo: todos[index],
          
           // говорим что будет отображаться список задач по его indexy
        );
      }
      );
  }

  
}