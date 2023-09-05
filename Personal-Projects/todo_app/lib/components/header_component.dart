import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        Text(
          '5 Incompleta, 5 Completas',
          style: myTheme.textTheme.displayMedium,
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
