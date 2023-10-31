import 'package:flutter/material.dart';
import 'package:todo_app/utils/consts_colors.dart';

final ThemeData myTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    background: kBackgroundColor,
    secondary: kFloatingActionButtonColor,
  ),
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
    labelSmall: TextStyle(
      fontFamily: 'Inter-Medium',
      fontWeight: FontWeight.w500,
      fontSize: 14,
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
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(10),
    hintStyle: const TextStyle(
      fontFamily: 'Inter-Medium',
      color: Colors.grey,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: kStrokeColor,
        strokeAlign: BorderSide.strokeAlignOutside,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(40),
    ),
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignOutside,
          width: 2,
          color: kBackgroundColor,
        ),
        borderRadius: BorderRadius.circular(40)),
  ),
  unselectedWidgetColor: kCheckBoxColor,
);
