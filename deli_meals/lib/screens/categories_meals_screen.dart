import 'package:flutter/material.dart';

import '../components/meal_item.dart';
import '../models/category.dart';
import '../utils/theme.dart';

import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoriesMealsScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    var category = ModalRoute.of(context)?.settings.arguments as Category;

    // filtra apenas as categoria específica
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        title: Text(category.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) {
          final _selectedMeal = categoryMeals[index];
          return MealItem(meal: _selectedMeal);
        },
      ),
    );
  }
}
