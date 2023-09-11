import 'package:flutter/material.dart';

import '../utils/consts_colors.dart';

class InputTodoComponent extends StatelessWidget {
  final TextEditingController todoController;

  const InputTodoComponent({super.key, required this.todoController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      child: Material(
        elevation: 10,
        shadowColor: kStrokeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: todoController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: 'Tarefa...',
            hintStyle: const TextStyle(
              fontFamily: 'Inter-Medium',
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: kBackgroundColor,
                strokeAlign: BorderSide.strokeAlignOutside,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kStrokeColor,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
