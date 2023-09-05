import '../models/todo_model.dart';

List<TodoModel> DUMMY_DATA = [
  TodoModel(
    id: 'T1',
    title: 'Fazer as compras',
    isDone: true,
    todoTag: TodoTag.Grocery,
  ),
  TodoModel(
    id: 'T2',
    title: 'Fazer planilhas',
    isDone: false,
    todoTag: TodoTag.Work,
  ),
  TodoModel(
    id: 'T3',
    title: 'Assistir Netflix',
    isDone: true,
    todoTag: TodoTag.Entertainment,
  ),
  TodoModel(
    id: 'T4',
    title: 'Ir à academia',
    isDone: false,
    todoTag: TodoTag.Health,
  ),
  TodoModel(
    id: 'T5',
    title: 'Pagar contas',
    isDone: true,
    todoTag: TodoTag.Personal,
  ),
  TodoModel(
    id: 'T6',
    title: 'Estudar para o exame',
    isDone: false,
    todoTag: TodoTag.Personal,
  ),
  TodoModel(
    id: 'T7',
    title: 'Limpar a casa',
    isDone: true,
    todoTag: TodoTag.Personal,
  ),
  TodoModel(
    id: 'T8',
    title: 'Trabalhar no projeto X',
    isDone: false,
    todoTag: TodoTag.Work,
  ),
  TodoModel(
    id: 'T9',
    title: 'Ler um livro',
    isDone: true,
    todoTag: TodoTag.Entertainment,
  ),
  TodoModel(
    id: 'T10',
    title: 'Fazer compras online',
    isDone: false,
    todoTag: TodoTag.Grocery,
  ),
];
