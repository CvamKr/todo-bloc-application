import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app_bloc/repositories/todo_repository.dart';

import '../../models/todo_model.dart';
import 'todos_event.dart';
import 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodoRepository todoRepository;
  TodosBloc({required this.todoRepository}) : super(InitialState(todos: [])) {
    on<LoadTodos>((event, emit) async {
      emit(InitialState(todos: []));
      try {
        final todos = await todoRepository.fetchTodos();
        emit(LoadedState(todos: [...todos]));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<AddTodo>((event, emit) async {
      try {
        await todoRepository.addTodo(event.todo);
        state.todos.add(event.todo);
        emit(LoadedState(todos: state.todos));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<UpdateTodo>((event, emit) async {
      final currentState = state;
      await todoRepository.updateTodo(event.updatedTodo);
      final index = currentState.todos
          .indexWhere((todo) => todo.id == event.updatedTodo.id);
      if (index != -1) {
        currentState.todos[index] = event.updatedTodo;
      }
      final updatedTodos = List<Todo>.from(currentState.todos);
      emit(LoadedState(todos: updatedTodos));
    });
    on<DeleteTodo>((event, emit) async {
      await todoRepository.deleteTodo(event.id);
      final updatedTodos = List<Todo>.from(state.todos)
        ..removeWhere((e) => e.id == event.id);
      emit(LoadedState(todos: updatedTodos));
    });

    on<FilterTodos>((event, emit) {
      final currentState = state;
      if (currentState is LoadedState) {
        emit(LoadedState(
          todos: currentState.todos,
          filter: event.filter,
        ));
      }
    });
  }

  List<Todo> getFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    switch (filter) {
      case VisibilityFilter.pending:
        return todos.where((todo) => !todo.isCompleted).toList();
      case VisibilityFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case VisibilityFilter.all:
        return todos;
      default:
        return todos;
    }
  }
}
