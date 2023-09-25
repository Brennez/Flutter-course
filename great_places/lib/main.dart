import 'package:flutter/material.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/place_form_screen.dart';
import '../screens/places_list_screen.dart';
import '../utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAILS: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
