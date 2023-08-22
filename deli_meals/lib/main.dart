import 'package:deli_meals/screens/categories_meals_screen.dart';
import 'package:deli_meals/screens/meal_detail.dart';
import 'package:deli_meals/utils/app_routes.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: myTheme,
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (context) => CategoriesScreen(),
        AppRoutes.CATEGORIES_MEALS: (context) => CategoriesMealsScreen(),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(),
      },
    );
  }
}
