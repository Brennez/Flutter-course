import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/todo_model.dart';

import '../utils/data.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = DUMMY_DATA;

  final List<IconData> _icons = const [
    FontAwesomeIcons.sackDollar,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.basketShopping,
    FontAwesomeIcons.display,
    FontAwesomeIcons.personRunning,
    FontAwesomeIcons.building,
    FontAwesomeIcons.pizzaSlice,
  ];

  List<IconData> get iconsList => [..._icons];

  List<TodoModel> get todosList {
    var filterList = _todos.where((todo) => todo.isDone == false).toList();
    filterList = [...filterList];
    return filterList;
  }

  List<TodoModel> get todosIsDoneList =>
      _todos.where((todo) => todo.isDone == true).toList();

  int get countTodosDone => todosIsDoneList.length;

  int get countTodos => todosList.length;

  void toggleFavorite(TodoModel todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void addTodo(Map<String, dynamic> data) {
    _todos.insert(
      0,
      TodoModel(
        id: Random().nextDouble().toString(),
        title: data['title'],
        todoTag: data['todoTag'],
        icon: data['IconData'],
      ),
    );
    notifyListeners();
  }

  void removeTodo(TodoModel todo) {
    final id = _todos.indexWhere((todoItem) => todoItem.id == todo.id);

    if (id != -1) {
      _todos.removeAt(id);
    }
  }
}
