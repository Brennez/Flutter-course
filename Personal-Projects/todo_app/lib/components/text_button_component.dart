import 'package:flutter/material.dart';

import '../utils/consts_colors.dart';

class TextButtonComponent extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final IconData icon;
  const TextButtonComponent({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
            Text(
              label,
              style: const TextStyle(color: kTextPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
