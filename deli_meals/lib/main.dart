import 'package:flutter/material.dart';

import '../screens/categories_meals_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tabs_screen.dart';
import '../utils/app_routes.dart';
import '../utils/theme.dart';

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
        AppRoutes.HOME: (context) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (context) => CategoriesMealsScreen(),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(),
        AppRoutes.SETTINGS: (context) => SettingScreen(),
      },
      // caso não encontre nenhuma rota, ele vai pra rota default
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => CategoriesScreen()));
      },
    );
  }
}
