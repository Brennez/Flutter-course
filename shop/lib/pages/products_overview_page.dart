import 'package:flutter/material.dart';

import '../components/product_grid.dart';
import '../utils/light_theme.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightTheme.colorScheme.primary,
        title: const Text('shopMy'),
        centerTitle: true,
      ),
      body: ProductGrid(),
    );
  }
}
