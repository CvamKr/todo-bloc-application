import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/pages/todo_list_page.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';

import 'blocs/todos_bloc/todos_bloc.dart';
import 'blocs/todos_bloc/todos_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final TodoRepository todoRepository = TodoRepository();
  await todoRepository.init();
  runApp(BlocProvider(
    create: (context) =>
        TodosBloc(todoRepository: todoRepository)..add(LoadTodos()),
    child: MyApp(todoRepository),
  ));
}

class MyApp extends StatelessWidget {
  TodoRepository todoRepository;
  MyApp(this.todoRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoListPage(),
    );
  }
}
