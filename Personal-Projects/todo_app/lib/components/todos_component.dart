import 'package:flutter/material.dart';
import 'package:todo_app/components/task_component.dart';
import 'package:todo_app/providers/todo_provider.dart';

import '../utils/consts_colors.dart';
import '../utils/my_theme.dart';

class TodosComponent extends StatelessWidget {
  final TodoProvider todoProvider;
  final BoxConstraints constraints;
  final String label;
  final bool isDoneTodos;

  const TodosComponent({
    super.key,
    required this.constraints,
    required this.label,
    required this.todoProvider,
    required this.isDoneTodos,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> _showConfirmationModal() async {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'Confirmação',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: kCheckBoxStrokeColor,
                  ),
            ),
            content: Text('Deseja excluir essa tarefa?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Sim'),
              ),
            ],
          );
        },
      );
    }

    bool getTodoList() => (isDoneTodos
        ? todoProvider.todosList.isEmpty
        : todoProvider.todosIsDoneList.isEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: constraints.maxHeight * 0.01,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.03,
          child: Text(
            label,
            style: myTheme.textTheme.bodyLarge,
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.01,
        ),
        SizedBox(
          height: getTodoList()
              ? constraints.maxHeight * .76
              : constraints.maxHeight * .35,
          child: ListView.builder(
            itemCount: isDoneTodos
                ? todoProvider.todosIsDoneList.length
                : todoProvider.todosList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (_) => todoProvider.removeTodo(index),
                confirmDismiss: (_) => _showConfirmationModal(),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.centerRight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                key: ValueKey<int>(index),
                child: TaskComponent(
                  todo: isDoneTodos
                      ? todoProvider.todosIsDoneList[index]
                      : todoProvider.todosList[index],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

// Incompleta 
// - height: todoProvider.todosIsDoneList.isEmpty
// - itemCount: todoProvider.todosList.length,
// - todo: todoProvider.todosList[index],

// Completas
// - height: todoProvider.todosList.isEmpty
// - itemCount: todoProvider.todosIsDoneList.length,
// - todo: todoProvider.todosIsDoneList[index]