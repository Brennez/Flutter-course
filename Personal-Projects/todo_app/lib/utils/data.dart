import 'package:flutter/material.dart';

import '../models/todo_model.dart';

List<TodoModel> DUMMY_DATA = [
  TodoModel(
    id: 'T1',
    title: 'Fazer as compras',
    isDone: true,
    todoTag: TodoTag.Grocery,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T2',
    title: 'Fazer planilhas',
    isDone: false,
    todoTag: TodoTag.Work,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T3',
    title: 'Assistir Netflix',
    isDone: true,
    todoTag: TodoTag.Entertainment,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T4',
    title: 'Ir à academia',
    isDone: false,
    todoTag: TodoTag.Health,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T5',
    title: 'Pagar contas',
    isDone: true,
    todoTag: TodoTag.Personal,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T6',
    title: 'Estudar para o exame',
    isDone: false,
    todoTag: TodoTag.Personal,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T7',
    title: 'Limpar a casa',
    isDone: true,
    todoTag: TodoTag.Personal,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T8',
    title: 'Trabalhar no projeto X',
    isDone: false,
    todoTag: TodoTag.Work,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T9',
    title: 'Ler um livro',
    isDone: true,
    todoTag: TodoTag.Entertainment,
    icon: Icons.monetization_on,
  ),
  TodoModel(
    id: 'T10',
    title: 'Fazer compras online',
    isDone: false,
    todoTag: TodoTag.Grocery,
    icon: Icons.monetization_on,
  ),
];
