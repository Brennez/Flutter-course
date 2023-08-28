import 'package:deli_meals/components/meal_item.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoriteScreens extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreens({super.key, required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'Sem refeições favoritas no momento!',
          style: myTheme.textTheme.bodyLarge!.copyWith(
            color: Colors.black54,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) {
          return MealItem(meal: favoriteMeals[index]);
        },
      );
    }
  }
}
