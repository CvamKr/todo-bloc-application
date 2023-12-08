import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos_bloc/todos_bloc.dart';
import '../blocs/todos_bloc/todos_event.dart';
import '../blocs/todos_bloc/todos_state.dart';
import '../models/todo_model.dart';
import '../widgets/filter_button.dart';
import 'add_todo_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodosBloc todoBloc = BlocProvider.of<TodosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is LoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
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
                      ? Expanded(
                          child: Center(
                              child: Column(
                          children: [
                            Image.network(
                                'https://static.vecteezy.com/system/resources/previews/005/073/059/original/empty-box-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-vector.jpg'),
                            Text("No Todos"),
                          ],
                        )))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: filteredTodos.length,
                            itemBuilder: (context, index) {
                              final Todo todo = filteredTodos[index];
                              return buildTodoCard(todo, context, todoBloc);
                            },
                          ),
                        ),
                ],
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => AddTodoPage(todo: Todo())));
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
              Expanded(child: Text(todo.title)),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => AddTodoPage(todo: todo)));
                },
              ),
            ],
          ),
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              Todo editedTodo = todo.copyWith(isCompleted: value);
              todoBloc.add(UpdateTodo(editedTodo));
            },
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
