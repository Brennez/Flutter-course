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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('MMMM d, yyyy').format(DateTime.now()),
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
