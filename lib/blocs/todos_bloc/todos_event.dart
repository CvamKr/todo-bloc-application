import 'package:todo_app_bloc/models/todo_model.dart';

abstract class TodosEvent {}

class LoadTodos extends TodosEvent {}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo);
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo);
}

class EditTodo extends TodosEvent {
  final int todoId;
  final Todo editedTodo;

  EditTodo(this.todoId, this.editedTodo);
}

class DeleteTodo extends TodosEvent {
  final int id;
  DeleteTodo(this.id);
}

class SelectForDeletion extends TodosEvent {
  final int id;

  SelectForDeletion(this.id);
}
class DeleteSelected extends TodosEvent {
  // final int id;

  DeleteSelected();
}

enum VisibilityFilter { all, pending, completed }

class FilterTodos extends TodosEvent {
  final VisibilityFilter filter;

  FilterTodos(this.filter);
}
