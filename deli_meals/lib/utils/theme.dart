import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  primaryColor: Colors.pink,
  fontFamily: 'Raleway',
  canvasColor: const Color.fromRGBO(255, 254, 229, 1),
  textTheme: ThemeData.light().textTheme.copyWith(
        bodyLarge: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        displaySmall: TextStyle(
          fontFamily: 'RobotoCondensed-Regular',
          fontSize: 16,
        ),
      ),
);
