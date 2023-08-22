import 'package:deli_meals/components/meal_item.dart';
import 'package:deli_meals/models/category.dart';
import 'package:deli_meals/utils/dummy_meals.dart';
import 'package:flutter/material.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var category = ModalRoute.of(context)?.settings.arguments as Category;

    // filtra apenas as categoria específica
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
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
