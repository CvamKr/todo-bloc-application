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
import 'package:equatable/equatable.dart';

import '../models/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends TodoState {
  @override
  List<Object?> get props => [];

  Loading();

  Loading copyWith() {
    return Loading();
  }
}

class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded(this.todos);

  @override
  List<Object?> get props => [todos];

  Loaded copyWith({
    List<Todo>? todos,
  }) {
    return Loaded(
      todos ?? this.todos,
    );
  }
}

class Error extends TodoState {
  final String message;

  Error(this.message);

  @override
  List<Object?> get props => [message];

  Error copyWith({
    String? message,
  }) {
    return Error(
      message ?? this.message,
    );
  }
}
