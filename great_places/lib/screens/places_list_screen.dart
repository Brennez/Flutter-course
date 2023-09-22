import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Lugares'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Consumer<GreatPlaces>(
          builder: (context, greatPlaces, child) {
            return greatPlaces.itemsCount == 0
                ? Center(
                    child: Text('Sem lugares por enquanto'),
                  )
                : ListView.builder(
                    itemCount: greatPlaces.itemsCount,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.itemByIndex(index).image,
                        ),
                      ),
                      title: Text(
                        greatPlaces.itemByIndex(index).title,
                      ),
                      onTap: () {},
                    ),
                  );
          },
        ));
  }
}
