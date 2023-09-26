import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';

import '../utils/consts_colors.dart';
import '../utils/my_theme.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});
// 'March 9, 2020',
  @override
  Widget build(BuildContext context) {
    // TODO: criar uma função para deixar o dia antes do Mês e concatenar com o restante da String
    // Por exemplo: 26 Setembro, 2023
    String dateFormated =
        DateFormat('MMMM d, yyyy', 'pt_BR').format(DateTime.now());
    dateFormated = dateFormated[0].toUpperCase() + dateFormated.substring(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateFormated,
          style: myTheme.textTheme.displayLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Consumer<TodoProvider>(
          builder: (context, todos, child) {
            return Text(
              '${todos.countTodos} Incompleta, ${todos.countTodosDone} Completas',
              style: myTheme.textTheme.displayMedium,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: kSubtitleTextColor,
          height: 2,
        ),
      ],
    );
  }
}
