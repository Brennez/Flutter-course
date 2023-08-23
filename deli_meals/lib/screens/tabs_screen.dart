import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/favorite_screens.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Vamos Cozinhar?',
            style: myTheme.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: myTheme.primaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.category_rounded,
                ),
                text: 'Categorias',
              ),
              Tab(
                icon: Icon(
                  Icons.favorite_border_rounded,
                ),
                text: 'Favoritos',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoriteScreens(),
          ],
        ),
      ),
    );
  }
}
