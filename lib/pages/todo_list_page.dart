import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';
import '../blocs/todo_state.dart';
import '../models/todo_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todo_app/bloc/todo_bloc.dart';
// import 'package:flutter_todo_app/bloc/todo_event.dart';
// import 'package:flutter_todo_app/bloc/todo_state.dart';
// import 'package:flutter_todo_app/models/todo.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body:
          //
          BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return state.todos.isEmpty
                ? const Center(child: Text("No Todos"))
                : ListView.builder(
                    itemCount: state.todos.length,
                    // itemCount: 11,

                    itemBuilder: (context, index) {
                      final Todo todo = state.todos[index];
                      // return TodoCard(todo: todo);
                      return buildTodoCard(todo, context, todoBloc);
                    },
                  );
          } else if (state is Error) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(Todo(id: DateTime.now().millisecondsSinceEpoch),
              context, todoBloc);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  buildTodoCard(Todo todo, context, TodoBloc todoBloc) {
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(child: Text(todo.id.toString())),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // todo.title = "f";
                  Todo todo = Todo(title: 'a');
                  todoBloc.add(EditTodo(todo.id, todo));
                },
              ),
            ],
          ),
          subtitle: Text(todo.title),
          leading: Checkbox(
            value: todo.isCompleted,
            // value: false,

            onChanged: (value) {
              // todo.isCompleted = value!;
              // context.read<TodoBloc>().add(UpdateTodo(todo.id));
              todoBloc.add(UpdateTodo(todo.id));
            },
            // checkColor: todo.isCompleted ? Colors.green : Colors.grey,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TodoBloc>().add(DeleteTodo(todo.id));
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showAddTodoDialog(
      Todo todo, BuildContext context, TodoBloc todoBloc) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            controller: TextEditingController(text: todo.title),
            onChanged: (value) {
              todo.title = value;
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
            // todo.title.isEmpty
            //     ?
            TextButton(
              onPressed: () {
                if (todo.title.isNotEmpty) {
                  todoBloc.add(AddTodo(todo));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            )
            // : TextButton(
            //     onPressed: () {
            //       if (todo.title.isNotEmpty) {
            //         todoBloc.add(UpdateTodo(todo));
            //         Navigator.of(context).pop();
            //       }
            //     },
            //     child: const Text('Update'),
            //   ),
          ],
        );
      },
    );
  }

  // Future<void> _showAddTodoDialog(
  //     BuildContext context, TodoBloc todoBloc) async {
  //   String todoTitle = '';

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Add Todo'),
  //         content: TextField(
  //           onChanged: (value) {
  //             todoTitle = value;
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
  //           TextButton(
  //             onPressed: () {
  //               if (todoTitle.isNotEmpty) {
  //                 todoBloc.add(AddTodo(Todo(
  //                   id: DateTime.now().millisecondsSinceEpoch,
  //                   title: todoTitle,
  //                 )));
  //                 Navigator.of(context).pop();
  //               }
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
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
