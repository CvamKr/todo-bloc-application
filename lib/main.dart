import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_event.dart';
import 'package:todo_app_bloc/pages/todo_list_page.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';

import 'blocs/todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final TodoRepository todoRepository = TodoRepository();
  await todoRepository.init();
  runApp(MyApp(todoRepository));
}

class MyApp extends StatelessWidget {
  TodoRepository todoRepository;
  MyApp(this.todoRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) =>
            TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
        child: TodoListPage(),
      ),
    );
  }
}
