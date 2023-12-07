// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_app_bloc/models/todo_model.dart';

// import '../repositories/todo_repository.dart';
// import 'todo_event.dart';
// import 'todo_state.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   final TodoRepository todoRepository = TodoRepository();
//   late List<Todo> _todos;

//   TodoBloc() : super(Loading()) {
//     _todos = todoRepository.getTodos();
//     add(LoadTodos());
//   }

//   @override
//   Stream<TodoState> mapEventToState(TodoEvent event) async* {
//     if (event is LoadTodos) {
//       yield* _mapLoadTodosToState();
//     } else if (event is AddTodo) {
//       // Handle AddTodo event
//       // ...
//     } else if (event is UpdateTodo) {
//       // Handle UpdateTodo event
//       // ...
//     } else if (event is DeleteTodo) {
//       // Handle DeleteTodo event
//       // ...
//     }

//     // else if (event is FilterTodos) {
//     //   yield* _mapFilterTodosToState(event.filterType);
//     // }
//   }

//   Stream<TodoState> _mapLoadTodosToState() async* {
//     yield Loaded(_todos);
//   }

//   // Stream<TodoState> _mapFilterTodosToState(FilterType filterType) async* {
//   //   List<Todo> filteredTodos;

//   //   switch (filterType) {
//   //     case FilterType.ALL:
//   //       filteredTodos = _todos;
//   //       break;
//   //     case FilterType.COMPLETE:
//   //       filteredTodos = _todos.where((todo) => todo.isCompleted).toList();
//   //       break;
//   //     case FilterType.INCOMPLETE:
//   //       filteredTodos = _todos.where((todo) => !todo.isCompleted).toList();
//   //       break;
//   //   }

//   //   yield Loaded(filteredTodos);
//   // }
// }

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_event.dart';
import 'package:todo_app_bloc/blocs/todo_state.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';

import '../models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository todoRepository;
  TodoBloc({required this.todoRepository}) : super(Loading()) {
    on<LoadTodos>((event, emit) async {
      emit(Loading());
      try {
        final todos = await todoRepository.fetchTodos();

        emit(Loaded(todos));
      } catch (e) {
        print(e);
        emit(Error('Failed to load todos'));
      }
    });
    on<AddTodo>((event, emit) async {
      if (state is Loaded) {
        final currentState = state as Loaded;
        await todoRepository.addTodo(event.todo);
        final updatedTodos = List<Todo>.from(currentState.todos)
          ..add(event.todo);
        emit(Loaded(updatedTodos));
      }
    });
    on<DeleteTodo>((event, emit) async {
      if (state is Loaded) {
        final currentState = state as Loaded;
        await todoRepository.deleteTodo(event.id);
        final updatedTodos = List<Todo>.from(currentState.todos)
          ..removeWhere((e) => e.id == event.id);
        emit(Loaded(updatedTodos));
      }
    });

    on<UpdateTodo>((event, emit) async {
      if (state is Loaded) {
        final currentState = state as Loaded;
        // await todoRepository.updateTodo(event.todoId);
        // final index = currentState.todos
        //     .indexWhere((todo) => todo.id == event.updatedTodo.id);
        // if (index != -1) {
        //   currentState.todos[index] = event.updatedTodo;
        // }

        // final updatedTodos = List<Todo>.from(currentState.todos)
        //   ..[index] = event.updatedTodo;

        final updatedTodos = currentState.todos.map((todo) {
          return todo.id == event.todoId
              ? todo.copyWith(isCompleted: !todo.isCompleted)
              : todo;
        }).toList();
        emit(Loaded(updatedTodos));
        // emit(currentState.copyWith(todos: updatedTodos));
      }

      // if (state is Loaded) {
      //   final currentState = state as Loaded;
      //   await todoRepository.updateTodo(event.updatedTodo);
      //   // final index = currentState.todos
      //   //     .indexWhere((todo) => todo.id == event.updatedTodo.id);
      //   // if (index != -1) {
      //   //   currentState.todos[index];
      //   // }
      //   final updatedTodos = currentState.todos.map((todo) {
      //     return todo.id == event.updatedTodo.id
      //         ? todo.copyWith(isCompleted: !todo.isCompleted)
      //         : todo;
      //   }).toList();

      //   // final updatedTodos = List<Todo>.from(currentState.todos)
      //   //   ..[index] = event.updatedTodo;

      //   final updatedTodos = currentState.todos.map((todo) {
      //     return todo.id == event.todoId
      //         ? todo.copyWith(isCompleted: !todo.isCompleted)
      //         : todo;
      //   }).toList();
      //   emit(Loaded(updatedTodos));
      //   // emit(currentState.copyWith(todos: updatedTodos));
      // }
    });

    on<EditTodo>((event, emit) async {
      if (state is Loaded) {
        final currentState = state as Loaded;
        // await todoRepository.updateTodo(event.todoId);
        // final index = currentState.todos
        //     .indexWhere((todo) => todo.id == event.updatedTodo.id);
        // if (index != -1) {
        //   currentState.todos[index] = event.updatedTodo;
        // }

        // final updatedTodos = List<Todo>.from(currentState.todos)
        //   ..[index] = event.updatedTodo;

        final updatedTodos = currentState.todos.map((todo) {
          return todo.id == event.todoId
              ? todo.copyWith(title: event.editedTodo.title)
              : todo;
        }).toList();

        emit(Loaded(updatedTodos));
        // emit(currentState.copyWith(todos: updatedTodos));
      }

      // if (state is Loaded) {
      //   final currentState = state as Loaded;
      //   await todoRepository.updateTodo(event.updatedTodo);
      //   // final index = currentState.todos
      //   //     .indexWhere((todo) => todo.id == event.updatedTodo.id);
      //   // if (index != -1) {
      //   //   currentState.todos[index];
      //   // }
      //   final updatedTodos = currentState.todos.map((todo) {
      //     return todo.id == event.updatedTodo.id
      //         ? todo.copyWith(isCompleted: !todo.isCompleted)
      //         : todo;
      //   }).toList();

      //   // final updatedTodos = List<Todo>.from(currentState.todos)
      //   //   ..[index] = event.updatedTodo;

      //   final updatedTodos = currentState.todos.map((todo) {
      //     return todo.id == event.todoId
      //         ? todo.copyWith(isCompleted: !todo.isCompleted)
      //         : todo;
      //   }).toList();
      //   emit(Loaded(updatedTodos));
      //   // emit(currentState.copyWith(todos: updatedTodos));
      // }
    });
  }
}
