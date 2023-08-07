import 'package:flutter/material.dart';

final myTheme = ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Colors.purple,
  secondaryHeaderColor: Colors.amber,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      color: Colors.black54,
      fontSize: 13,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      // fontWeight: FontWeight.w200,
      fontSize: 12,
      fontFamily: 'Quicksand',
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
