import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';

class TodoRepository {
  late SharedPreferences _preferences;
  late List<Todo> _todos;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _todos = [];
  }

  Future<List<Todo>> fetchTodos() async {
    final todoList = _preferences.getStringList('todos') ?? [];
    _todos = todoList
        .map((json) =>
            Todo.fromJson(Map<String, dynamic>.from(jsonDecode(json))))
        .toList();
    return _todos;
  }

  Future<void> saveTodos() async {
    final List<String> jsonList =
        _todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await _preferences.setStringList('todos', jsonList);
  }

  List<Todo> getTodos() {
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    await saveTodos();
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);

    if (index != -1) {
      _todos[index] = updatedTodo;
      await saveTodos();
    }
  }

  Future<void> deleteTodo(int id) async {
    _todos.removeWhere((todo) => todo.id == id);
    await saveTodos();
  }

}
