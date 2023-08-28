import 'package:deli_meals/components/main_drawer.dart';
import 'package:deli_meals/models/settings.dart';
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class SettingScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChange;

  const SettingScreen(
      {super.key, required this.onSettingsChange, required this.settings});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Settings? settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          activeColor: myTheme.primaryColor,
          value: value,
          title: Text(
            title,
            style: myTheme.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle),
          onChanged: (value) {
            onChanged(value);
            widget.onSettingsChange(settings!);
          },
        ),
        Divider(
          color: myTheme.primaryColor,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: myTheme.primaryColor,
          title: const Text('Configurações'),
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Configurações',
                style: myTheme.textTheme.bodyLarge!.copyWith(
                  color: Colors.black54,
                ),
              ),
            ),
            _createSwitch(
              title: 'Sem Glutén',
              subtitle: 'Exibe apenas receitas sem glútem',
              value: settings!.isGlutenFree,
              onChanged: (value) =>
                  setState(() => settings!.isGlutenFree = value),
            ),
            _createSwitch(
              title: 'Sem Lactose',
              subtitle: 'Exibe apenas receitas sem lactose',
              value: settings!.isLactoseFree,
              onChanged: (value) =>
                  setState(() => settings!.isLactoseFree = value),
            ),
            _createSwitch(
              title: 'Vegana',
              subtitle: 'Exibe apenas receitas veganas',
              value: settings!.isVegan,
              onChanged: (value) => setState(() => settings!.isVegan = value),
            ),
            _createSwitch(
              title: 'Vegetariana',
              subtitle: 'Exibe apenas receitas vegetarianas',
              value: settings!.isVegetarian,
              onChanged: (value) =>
                  setState(() => settings!.isVegetarian = value),
            ),
          ],
        ));
  }
}
