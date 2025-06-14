import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/text_button_component.dart';
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
  final TextEditingController _todoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TodoTag _tag = TodoTag.Personal;
  IconData _selectedIcon = FontAwesomeIcons.faceSmile;
  String _stringTag = 'Tags';

  final Map<String, Object> _formData = {};

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

  IconData getIcon(String iconIndex) {
    switch (iconIndex) {
      case 'icon-1':
        return FontAwesomeIcons.sackDollar;
      case 'icon-2':
        return FontAwesomeIcons.heartPulse;
      case 'icon-3':
        return FontAwesomeIcons.basketShopping;
      case 'icon-4':
        return FontAwesomeIcons.display;
      case 'icon-5':
        return FontAwesomeIcons.personRunning;
      case 'icon-6':
        return FontAwesomeIcons.building;
      case 'icon-7':
        return FontAwesomeIcons.pizzaSlice;

      default:
        return Icons.block;
    }
  }

  Widget _dropDownMenuTags() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropDownMenuIcons() {
    TodoProvider todoProvider = Provider.of(context);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        int iconIndex = 0;
        return todoProvider.iconsList.map((icon) {
          iconIndex++;
          return PopupMenuItem(
            value: 'icon-$iconIndex',
            height: 4,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: FaIcon(
                  icon,
                  color: kStrokeColor,
                ),
              ),
            ),
          );
        }).toList();
      },
      onSelected: (value) {
        setState(() {
          _selectedIcon = getIcon(value);
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
              FaIcon(
                _selectedIcon,
                color: kStrokeColor,
              ),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context, listen: true);

    void _submitForm() {
      bool isValid = _formKey.currentState?.validate() ?? false;
      print(isValid);
      if (!isValid) return;

      _formData['title'] = _todoController.text;
      _formData['todoTag'] = _tag;
      _formData['IconData'] = _selectedIcon;

      provider.addTodo({
        'title': _formData['title'],
        'todoTag': _formData['todoTag'],
        'IconData': _formData['IconData'],
      });

      Navigator.of(context).pop();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .85,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (_todo) {
                        String todo = _todo ?? '';
                        if (todo.isEmpty) {
                          return 'O campo não pode ser vazio!';
                        }
                        return null;
                      },
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
                        child: _dropDownMenuTags(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _dropDownMenuIcons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButtonComponent(
                      backgroundColor: kStrokeColor,
                      label: 'Voltar',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icons.arrow_back),
                  TextButtonComponent(
                    backgroundColor: kSuccessColor,
                    label: 'Adicionar',
                    icon: Icons.add,
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
