import 'package:flutter/material.dart';

import 'custom_route.dart';

ThemeData lightTheme = ThemeData(
  canvasColor: Color.fromRGBO(255, 255, 245, 1),
  colorScheme: ColorScheme.light(primary: Colors.black),
  fontFamily: 'Lato',
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CustomPageTransitionsBuilder(),
    },
  ),
);
