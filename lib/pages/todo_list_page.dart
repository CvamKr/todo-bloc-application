import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../blocs/todo_state.dart';
import '../blocs/todos_bloc/todos_bloc.dart';
import '../blocs/todos_bloc/todos_event.dart';
import '../blocs/todos_bloc/todos_state.dart';
import '../models/todo_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todo_app/bloc/todo_bloc.dart';
// import 'package:flutter_todo_app/bloc/todo_event.dart';
// import 'package:flutter_todo_app/bloc/todo_state.dart';
// import 'package:flutter_todo_app/models/todo.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodosBloc todoBloc = BlocProvider.of<TodosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is LoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Todos Refreshed'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              final filteredTodos =
                  todoBloc.getFilteredTodos(state.todos, state.filter);

              return Column(
                children: [
                  filterOptions(todoBloc),
                  filteredTodos.isEmpty
                      ? const Expanded(child: Center(child: Text("No Todos")))
                      : Expanded(
                          child: ListView.builder(
                            // itemCount: state.todos.length,
                            itemCount: filteredTodos.length,

                            itemBuilder: (context, index) {
                              // final Todo todo = state.todos[index];
                              final Todo todo = filteredTodos[index];

                              // return TodoCard(todo: todo);
                              return buildTodoCard(todo, context, todoBloc);
                            },
                          ),
                        ),
                ],
              );
            } else if (state is Error) {
              return const Center(child: Text("error"));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showAddTodoDialog(Todo(id: DateTime.now().millisecondsSinceEpoch),
          //     context, todoBloc);
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => AddTodoCard(todo: Todo())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Row filterOptions(TodosBloc todoBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterButton(
          filter: VisibilityFilter.all,
          onPressed: () {
            todoBloc.add(FilterTodos(VisibilityFilter.all));
          },
          text: 'All',
          isSelected: todoBloc.state is LoadedState &&
              (todoBloc.state as LoadedState).filter == VisibilityFilter.all,
        ),
        FilterButton(
          filter: VisibilityFilter.pending,
          onPressed: () {
            todoBloc.add(FilterTodos(VisibilityFilter.pending));
          },
          text: 'Pending',
          isSelected: todoBloc.state is LoadedState &&
              (todoBloc.state as LoadedState).filter ==
                  VisibilityFilter.pending,
        ),
        FilterButton(
          filter: VisibilityFilter.completed,
          onPressed: () {
            todoBloc.add(FilterTodos(VisibilityFilter.completed));
          },
          text: 'Completed',
          isSelected: todoBloc.state is LoadedState &&
              (todoBloc.state as LoadedState).filter ==
                  VisibilityFilter.completed,
        ),
      ],
    );
  }

  buildTodoCard(Todo todo, context, TodosBloc todoBloc) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(child: Text(todo.id.toString())),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => AddTodoCard(todo: todo)));
                },
              ),
            ],
          ),
          subtitle: Text(todo.title),
          leading: Checkbox(
            value: todo.isCompleted,
            // value: false,

            onChanged: (value) {
              Todo editedTodo = todo.copyWith(isCompleted: value);
              todoBloc.add(UpdateTodo(editedTodo));
            },
            // checkColor: todo.isCompleted ? Colors.green : Colors.grey,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              todoBloc.add(DeleteTodo(todo.id));
            },
          ),
        ),
      ],
    );
  }
}

class AddTodoCard extends StatelessWidget {
  Todo todo;
  AddTodoCard({super.key, required this.todo});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return Scaffold(
      appBar:
          AppBar(title: Text(todo.title.isEmpty ? "Add Todo" : "Edit Todo")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController..text = todo.title,
              onChanged: (value) {
                titleController.text = value;
              },
              decoration: const InputDecoration(hintText: 'Enter todo'),
            ),
            TextButton(
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

    AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: titleController..text = todo.title,
        onChanged: (value) {
          titleController.text = value;
        },
        decoration: const InputDecoration(hintText: 'Enter todo'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        titleController.text.isEmpty
            ? TextButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    // todosBloc.add(AddTodo(todo));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              )
            : TextButton(
                onPressed: () {
                  if (todo.title.isNotEmpty) {
                    // todosBloc.add(UpdateTodo(todo));
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Update'),
              ),
      ],
    );
  }
}

// Future<void> _showAddTodoDialog(Todo todo, BuildContext context) async {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Add Todo'),
//         content: TextField(
//           controller: TextEditingController(text: todo.title),
//           onChanged: (value) {
//             todo.title = value;
//           },
//           decoration: const InputDecoration(hintText: 'Enter todo'),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           // todo.title.isEmpty
//           //     ?
//           TextButton(
//             onPressed: () {
//               if (todo.title.isNotEmpty) {
//                 context.read<TodoBloc>().add(AddTodo(todo));
//                 Navigator.of(context).pop();
//               }
//             },
//             child: const Text('Add'),
//           )
//           // : TextButton(
//           //     onPressed: () {
//           //       if (todo.title.isNotEmpty) {
//           //         todoBloc.add(UpdateTodo(todo));
//           //         Navigator.of(context).pop();
//           //       }
//           //     },
//           //     child: const Text('Update'),
//           //   ),
//         ],
//       );
//     },
//   );
// }

// class TodoCard extends StatelessWidget {
//   const TodoCard({
//     super.key,
//     required this.todo,
//   });

//   final Todo todo;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.edit),
//           onPressed: () {
//             // todoBloc.add(UpdateTodo(todo));
//             // _showAddTodoDialog(todo, context);
//           },
//         ),
//         ListTile(
//           title: Text(todo.id.toString()),
//           subtitle: Text(todo.title),
//           leading: Checkbox(
//             value: todo.isCompleted,
//             // value: false,

//             onChanged: (value) {
//               // todo.isCompleted = value!;
//               context.read<TodoBloc>().add(UpdateTodo(todo.id));
//             },
//             // checkColor: todo.isCompleted ? Colors.green : Colors.grey,
//           ),
//           trailing: IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               context.read<TodoBloc>().add(DeleteTodo(todo.id));
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
class FilterButton extends StatelessWidget {
  final VisibilityFilter filter;
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  const FilterButton({
    required this.filter,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all(Theme.of(context).primaryColorDark)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
