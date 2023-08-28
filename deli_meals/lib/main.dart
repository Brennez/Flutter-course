import 'package:deli_meals/models/settings.dart';
import 'package:deli_meals/utils/dummy_meals.dart';
import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import '../screens/categories_meals_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tabs_screen.dart';

import '../utils/app_routes.dart';
import '../utils/theme.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoritMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      // Se a refeição não atender a pelo menos uma preferência que o usuário selecionou
      // (por exemplo, se o usuário quiser comida sem glúten e a refeição tiver glúten),
      // então a variável de filtro correspondente será true,
      // indicando que a refeição não deve ser incluída.
      _avaliableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoritMeals.contains(meal)
          ? _favoritMeals.remove(meal)
          : _favoritMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoritMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: myTheme,
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (context) => TabsScreen(favoriteMeals: _favoritMeals),
        AppRoutes.CATEGORIES_MEALS: (context) =>
            CategoriesMealsScreen(meals: _avaliableMeals),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(
            onToggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (context) => SettingScreen(
              onSettingsChange: (settings) => _filterMeals(settings),
              settings: settings,
            ),
      },
      // caso não encontre nenhuma rota, ele vai pra rota default
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => CategoriesScreen()));
      },
    );
  }
}
