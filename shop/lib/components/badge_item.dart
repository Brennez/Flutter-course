import 'package:flutter/material.dart';

class BadgeItem extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;
  const BadgeItem(
      {super.key, required this.child, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right: 5,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color ?? const Color.fromARGB(255, 46, 61, 46),
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minHeight: 16,
                minWidth: 16,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ))
      ],
    );
  }
}
