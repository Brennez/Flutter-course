import 'package:deli_meals/components/category_item.dart';
import 'package:deli_meals/utils/dummy_categories.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vamos cozinhar?'),
        centerTitle: true,
      ),
      body: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES.map((category) {
            return CategoryItem(category: category);
          }).toList()),
    );
  }
}
