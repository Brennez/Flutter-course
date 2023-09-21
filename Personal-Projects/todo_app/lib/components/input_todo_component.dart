import 'package:flutter/material.dart';

import '../utils/consts_colors.dart';

class InputTodoComponent extends StatefulWidget {
  final TextEditingController todoController;

  const InputTodoComponent({
    Key? key,
    required this.todoController,
  });

  @override
  State<InputTodoComponent> createState() => _InputTodoComponentState();
}

class _InputTodoComponentState extends State<InputTodoComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      child: Material(
        elevation: 10,
        shadowColor: kStrokeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          controller: widget.todoController,
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
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
