import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/my_theme.dart';

import '../utils/consts_colors.dart';

class TodoFormComponent extends StatefulWidget {
  const TodoFormComponent({super.key});

  @override
  State<TodoFormComponent> createState() => _TodoFormComponentState();
}

class _TodoFormComponentState extends State<TodoFormComponent> {
  TodoTag _tag = TodoTag.Personal;
  String _stringTag = 'Tags';
  TextEditingController _todoController = new TextEditingController();

  Map<String, Object> _formData = {};

  String getTextTag(TodoTag todoTag) {
    switch (todoTag) {
      case TodoTag.Personal:
        return 'Pessoal';
      case TodoTag.Work:
        return 'Trabalho';
      case TodoTag.Grocery:
        return 'Mercado';
      case TodoTag.Health:
        return 'Saúde';
      case TodoTag.Entertainment:
        return 'Entreterimento';

      default:
        return 'Tag desconhecida';
    }
  }

  void _submitForm(TodoProvider provider) {
    _formData['title'] = _todoController.text;
    _formData['todoTag'] = _tag;
    _formData['IconData'] = Icons.money;

    provider.addTodo({
      'title': _formData['title'],
      'todoTag': _formData['todoTag'],
      'IconData': Icons.money,
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Adicione uma tarefa',
            style: myTheme.textTheme.bodyLarge
                ?.copyWith(color: kBackgroundColor, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: Material(
              elevation: 10,
              shadowColor: kStrokeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Tarefa...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter-Medium',
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kBackgroundColor,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: kStrokeColor,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: TodoTag.Personal,
                          child: Text(
                            'Pessoal',
                            style: myTheme.textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: TodoTag.Work,
                          child: Text(
                            'Trabalho',
                            style: myTheme.textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: TodoTag.Grocery,
                          child: Text(
                            'Mercado',
                            style: myTheme.textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: TodoTag.Health,
                          child: Text(
                            'Saúde',
                            style: myTheme.textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: TodoTag.Entertainment,
                          child: Text(
                            'Entretenimento',
                            style: myTheme.textTheme.displayMedium,
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      setState(() {
                        _tag = value;
                        _stringTag = getTextTag(value);
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: kBackgroundColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _stringTag,
                              style: myTheme.textTheme.displayMedium,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: '',
                          child: Text('Icone 1'),
                        ),
                        PopupMenuItem(
                          value: '',
                          child: Text('Icone 2'),
                        ),
                        PopupMenuItem(
                          value: '',
                          child: Text('Icone 3'),
                        ),
                        PopupMenuItem(
                          value: '',
                          child: Text('Icone 4'),
                        ),
                        PopupMenuItem(
                          value: '',
                          child: Text('Icone 5'),
                        ),
                      ];
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: kBackgroundColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ícones',
                              style: myTheme.textTheme.displayMedium,
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: kStrokeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Voltar',
                        style: TextStyle(color: kTextPrimaryColor),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: const Color.fromARGB(255, 71, 129, 73),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    onPressed: () {
                      _submitForm(provider);
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Adicionar',
                          style: TextStyle(color: kTextPrimaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add,
                          size: 18,
                          color: kTextPrimaryColor,
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
