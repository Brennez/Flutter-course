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

  void addTodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
