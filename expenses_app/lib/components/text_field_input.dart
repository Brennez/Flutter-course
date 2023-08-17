import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TransactionInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function() onSubmit;
  const TransactionInput(
      {super.key,
      required this.controller,
      required this.label,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: const TextStyle(
            color: Colors.purple,
          ),
          controller: controller,
          onSubmitted: (_) => onSubmit,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: myTheme.colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: myTheme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
