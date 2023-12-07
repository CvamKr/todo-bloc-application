// import 'package:equatable/equatable.dart';
// import 'package:todo_app_bloc/models/todo_model.dart';

// abstract class TodoEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadTodos extends TodoEvent {}

// class AddTodo extends TodoEvent {
//   final Todo todo;

//   AddTodo(this.todo);
//   @override
//   List<Object?> get props => [todo];
// }

// // class UpdateTodo extends TodoEvent {
// //   final Todo updatedTodo;

// //   UpdateTodo(this.updatedTodo);
// //   @override
// //   List<Object?> get props => [updatedTodo];
// // }
// class UpdateTodo extends TodoEvent {
//   final int todoId;

//   UpdateTodo(this.todoId);
//   @override
//   List<Object?> get props => [todoId];
// }

// class EditTodo extends TodoEvent {
//   final int todoId;
//   final Todo editedTodo;

//   EditTodo(this.todoId, this.editedTodo);
//   @override
//   List<Object?> get props => [todoId, editedTodo];
// }



// class DeleteTodo extends TodoEvent {
//   final int id;
//   DeleteTodo(this.id);
//   @override
//   List<Object?> get props => [id];
// }

// class FilterTodos extends TodoEvent {
//   final FilterType filterType;

//   FilterTodos(this.filterType);

//   @override
//   List<Object?> get props => [filterType];
// }
