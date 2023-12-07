import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends TodoState {}

class Loaded extends TodoState {
 final List<Todo> todos;

  Loaded(this.todos);

  @override
  List<Object?> get props => [todos];
}

class Error extends TodoState {
  final String message;
  Error(this.message);

  @override
  List<Object?> get props => [message];
}
