import 'package:deli_meals/utils/app_routes.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      enableFeedback: true,
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black54,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.amber[400],
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(20),
            child: Text(
              'Vamos cozinhar?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                fontFamily: 'RobotoCondensed',
                color: myTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _createItem(
            Icons.restaurant_rounded,
            'Refeições',
            () => Navigator.pushReplacementNamed(context, AppRoutes.HOME),
          ),
          _createItem(
            Icons.settings,
            'Configurações',
            () => Navigator.pushReplacementNamed(context, AppRoutes.SETTINGS),
          ),
        ],
      ),
    );
  }
}
