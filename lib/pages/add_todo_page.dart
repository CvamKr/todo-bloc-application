import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos_bloc/todos_bloc.dart';
import '../blocs/todos_bloc/todos_event.dart';
import '../models/todo_model.dart';

class AddTodoPage extends StatelessWidget {
  Todo todo;
  AddTodoPage({super.key, required this.todo});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return Scaffold(
      appBar:
          AppBar(title: Text(todo.title.isEmpty ? "Add Todo" : "Edit Todo")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Image.network(
                "https://assets.materialup.com/uploads/690e1066-72f7-4fe0-b0ec-28e456332b8c/preview.jpg"),
            TextField(
              controller: titleController..text = todo.title,
              onChanged: (value) {
                titleController.text = value;
              },
              decoration: const InputDecoration(hintText: 'Enter todo'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final String newTitle = titleController.text.trim();
                if (newTitle.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title cannot be empty')),
                  );
                  return;
                }
                if (todo.title.isEmpty) {
                  // Adding new todo
                  Todo newTodo = Todo(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: newTitle);
                  todosBloc.add(AddTodo(newTodo));
                } else {
                  // Updating existing todo
                  Todo editedTodo = todo.copyWith(title: newTitle);
                  todosBloc.add(UpdateTodo(editedTodo));
                }
                Navigator.of(context).pop();
              },
              child: Text(todo.title.isEmpty ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
