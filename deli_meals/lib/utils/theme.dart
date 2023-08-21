import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
    primarySwatch: Colors.pink,
    primaryColor: Colors.pink,
    fontFamily: 'Raleway',
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
    textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
        )));
