import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/header_component.dart';
import 'package:todo_app/providers/todo_provider.dart';

import '../components/task_component.dart';
import '../components/todo_form_modal_component.dart';
import '../utils/consts_colors.dart';
import '../utils/my_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

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

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.12,
                      child: HeaderComponent(),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    if (todoProvider.todosList.isEmpty &&
                        todoProvider.todosIsDoneList.isEmpty)
                      SizedBox(
                        height: constraints.maxHeight * .80,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sem tarefas por enquanto. Relaxe!',
                                textAlign: TextAlign.center,
                                style: myTheme.textTheme.bodyLarge?.copyWith(
                                  color: kSubtitleTextColor,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  'assets/images/waiting.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (todoProvider.todosList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                            child: Text(
                              'Incompletas',
                              style: myTheme.textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          SizedBox(
                            height: constraints.maxHeight *
                                (todoProvider.todosIsDoneList.isEmpty
                                    ? .76
                                    : .35),
                            child: ListView.builder(
                              itemCount: todoProvider.todosList.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  onDismissed: (_) {
                                    todoProvider.removeTodo(index);
                                  },
                                  confirmDismiss: (_) =>
                                      _showConfirmationModal(),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                    todo: todoProvider.todosList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    if (todoProvider.todosIsDoneList.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                            child: Text(
                              'Completas',
                              style: myTheme.textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          SizedBox(
                            height: todoProvider.todosList.isEmpty
                                ? constraints.maxHeight * .76
                                : constraints.maxHeight * .35,
                            child: ListView.builder(
                              itemCount: todoProvider.todosIsDoneList.length,
                              itemBuilder: (context, index) {
                                return TaskComponent(
                                  todo: todoProvider.todosIsDoneList[index],
                                );
                              },
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return TodoFormComponent();
              },
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: kStrokeColor,
              strokeAlign: BorderSide.strokeAlignOutside,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: kTextPrimaryColor,
          ),
        ),
      );
    });
  }
}
