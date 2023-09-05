import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';

import '../utils/consts_colors.dart';
import '../utils/my_theme.dart';

class TaskComponent extends StatelessWidget {
  final TodoModel todo;
  const TaskComponent({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: true);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            provider.toggleFavorite(todo);
          },
          child: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: kSubtitleTextColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: kStrokeColor,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: todo.isDone
                ? const Icon(
                    Icons.check,
                    size: 20,
                    weight: 700,
                    color: Colors.white,
                  )
                : Container(),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: ListTile(
            title: Text(todo.title,
                style: todo.isDone
                    ? myTheme.textTheme.bodyMedium!.copyWith(
                        color: kSubtitleTextColor,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                      )
                    : myTheme.textTheme.bodyMedium),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Icon(
                    Icons.monetization_on,
                    color: kFloatingActionButtonColor,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  todo.textTag,
                  style: myTheme.textTheme.displayMedium,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

// todo.isDone
//                   ? myTheme.textTheme.bodyMedium
//                   : myTheme.textTheme.bodyMedium!.copyWith(
//                       color: kSubtitleTextColor,
//                       decoration: TextDecoration.lineThrough,
//                       decorationThickness: 2,
//                     ),