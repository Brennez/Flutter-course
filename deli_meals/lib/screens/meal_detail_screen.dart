import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatefulWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;
  const MealDetailScreen(
      {super.key, required this.onToggleFavorite, required this.isFavorite});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: myTheme.textTheme.bodyLarge!.copyWith(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _createSectionContainer(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * .9,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        title: Text(meal.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width * .9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _createSectionTitle(context, 'Ingredientes'),
              _createSectionContainer(
                context,
                ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text('${meal.ingredients[index]}'),
                      ),
                    );
                  },
                ),
              ),
              _createSectionTitle(context, 'Passos'),
              _createSectionContainer(
                context,
                ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: myTheme.primaryColor,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(meal.steps[index]),
                        ),
                        Divider(
                          indent: 0.5,
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onToggleFavorite(meal);
        },
        backgroundColor: myTheme.primaryColor,
        child: Icon(
          widget.isFavorite(meal)
              ? Icons.favorite_rounded
              : Icons.favorite_outline_rounded,
          size: 30,
        ),
      ),
    );
  }
}
