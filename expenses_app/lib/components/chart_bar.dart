import 'package:expenses_app/utils/theme.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '${value == 0.0 ? '_' : value.toStringAsFixed(2)}',
                  style: myTheme.textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey,
                ),
                color: const Color.fromRGBO(220, 220, 220, 1),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: myTheme.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
