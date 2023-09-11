import 'package:flutter/material.dart';

enum TodoTag {
  Personal,
  Work,
  Grocery,
  Health,
  Entertainment,
}

class TodoModel {
  final String id;
  final String title;
  final TodoTag todoTag;
  final IconData icon;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.todoTag,
    required this.icon,
    this.isDone = false,
  });

  String get textTag {
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
}
