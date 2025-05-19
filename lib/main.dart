

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/bloc/todo_bloc.dart';
import 'package:to_do/bloc/todo_event.dart';
import 'package:to_do/data/repository/todo_repository.dart';
import 'package:to_do/screens/homescreen.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        create: (context) {
        final repository = RepositoryProvider.of<TodoRepository>(context);
        final bloc = TodoBloc(repository: repository);
        bloc.add(LoadTodo());
        return bloc;
      },
      child: MaterialApp(
        home: Homescreen()
      ),
        ),
      );
  }
  
}




