import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';

import '../utils/consts_colors.dart';
import '../utils/my_theme.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  String dateFormater(DateTime date) {
    String dayFormated = DateFormat('d ').format(date);

    String dateFormated = DateFormat('MMMM, yyyy', 'pt_BR').format(date);

    return dayFormated +
        dateFormated[0].toUpperCase() +
        dateFormated.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateFormater(DateTime.now()),
          style: myTheme.textTheme.displayLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Consumer<TodoProvider>(
          builder: (context, todos, child) {
            bool isVisible = todos.countTodos > 0 || todos.countTodosDone > 0;
            return isVisible
                ? Text(
                    '${todos.countTodos} Incompletas, ${todos.countTodosDone} Completas',
                    style: myTheme.textTheme.displayMedium,
                  )
                : const SizedBox();
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
