import 'package:deli_meals/components/main_drawer.dart';
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('tela de configurações'),
      ),
    );
  }
}
