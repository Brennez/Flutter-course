import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/data.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = DUMMY_DATA;

  List<TodoModel> get todosList {
    var filterList = _todos.where((todo) => todo.isDone == false).toList();
    filterList = [...filterList];
    return filterList;
  }

  List<TodoModel> get todosIsDoneList =>
      _todos.where((todo) => todo.isDone == true).toList();

  void toggleFavorite(TodoModel todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void addTodo(Map<String, dynamic> data) {
    _todos.add(
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
