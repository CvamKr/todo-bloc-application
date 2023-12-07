// import 'package:equatable/equatable.dart';
// import 'package:todo_app_bloc/models/todo_model.dart';

// abstract class TodoState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class Loading extends TodoState {}

// class Loaded extends TodoState {
//  final List<Todo> todos;

//   Loaded(this.todos);

//   @override
//   List<Object?> get props => [todos];
// }

// class Error extends TodoState {
//   final String message;
//   Error(this.message);

//   @override
//   List<Object?> get props => [message];
// }
import 'package:todo_app_bloc/blocs/todos_bloc/todos_event.dart';

import '../../models/todo_model.dart';

abstract class TodosState {
  List<Todo> todos;
  TodosState({required this.todos});
}

class InitialState extends TodosState {
  InitialState({required List<Todo> todos}) : super(todos: todos);

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is InitialState &&
  //         runtimeType == other.runtimeType &&
  //         todos == other.todos;
  // @override
  // int get hashCode => todos.hashCode;
}

// class LoadedState extends TodosState {
//   VisibilityFilter filter;

//   LoadedState({required List<Todo> todos, this.filter = VisibilityFilter.all})
//       : super(todos: todos);

// }

class LoadedState extends TodosState {
  VisibilityFilter filter;

  LoadedState({required List<Todo> todos, this.filter = VisibilityFilter.all})
      : super(todos: todos);

  // @override
  // int get hashCode {
  //   return todos.hashCode ^ filter.hashCode;
  // }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is LoadedState &&
  //         runtimeType == other.runtimeType &&
  //         todos == other.todos &&
  //         filter == other.filter;
}