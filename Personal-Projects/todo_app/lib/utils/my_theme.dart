import 'package:flutter/material.dart';
import 'package:todo_app/utils/consts_colors.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: kBackgroundColor,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Inter-Bold',
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: kTextPrimaryColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter-SemiBold',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: kSubtitleTextColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter-Bold',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: kTextPrimaryColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter-Medium',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: kTextPrimaryColor,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kFloatingActionButtonColor,
    iconSize: 20,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: kStrokeColor,
      ),
    ),
  ),
  unselectedWidgetColor: kCheckBoxColor,
);
