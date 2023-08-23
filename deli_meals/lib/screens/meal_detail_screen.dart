import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/utils/theme.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: myTheme.textTheme.bodyLarge,
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
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
        appBar: AppBar(
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
                              child: Text('${index + 1}'),
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
        ));
  }
}
