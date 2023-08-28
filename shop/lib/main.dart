import 'package:flutter/material.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/utils/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopMy',
      theme: lightTheme,
      home: ProductsOverviewPage(),
    );
  }
}
