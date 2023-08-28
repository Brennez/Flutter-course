import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/favorite_screens.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({super.key, required this.favoriteMeals});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  List<Map<String, Object>> _screens = [];

  @override
  void initState() {
    super.initState();

    _screens = [
      {
        'title': 'Categorias',
        'screen': CategoriesScreen(),
      },
      {
        'title': 'Receitas Favoritas',
        'screen': FavoriteScreens(favoriteMeals: widget.favoriteMeals),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[_selectedScreenIndex]['title'] as String,
          style: myTheme.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: myTheme.primaryColor,
      ),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myTheme.primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[200],
        currentIndex: _selectedScreenIndex,
        onTap: (index) => _selectScreen(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
