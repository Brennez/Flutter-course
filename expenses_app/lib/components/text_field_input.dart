import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TransactionInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function() onSubmit;
  final TextInputType keyboardType;
  const TransactionInput({
    super.key,
    required this.controller,
    required this.label,
    required this.onSubmit,
    required this.keyboardType,
  });

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
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
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
