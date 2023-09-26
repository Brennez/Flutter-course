import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff422B6D),
  canvasColor: Colors.black54,
  fontFamily: 'RobotoMono',
  useMaterial3: true,
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Color(0xff422B6D),
    ),
  ),
  //
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      color: Color(0xff422B6D),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  ),
);
