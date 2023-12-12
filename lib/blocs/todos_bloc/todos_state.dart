import 'package:todo_app_bloc/blocs/todos_bloc/todos_event.dart';

import '../../models/todo_model.dart';

abstract class TodosState {
  List<Todo> todos;
  TodosState({required this.todos});
}

class InitialState extends TodosState {
  InitialState({required List<Todo> todos}) : super(todos: todos);
}

class LoadedState extends TodosState {
  VisibilityFilter filter;
  List<int> listToDelete ;

  LoadedState({required List<Todo> todos, this.filter = VisibilityFilter.all, required this.listToDelete})
      : super(todos: todos);
}
