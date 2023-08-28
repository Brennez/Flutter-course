import 'package:flutter/material.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/utils/light_theme.dart';
import '../data/dummy_data.dart';

import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightTheme.colorScheme.primary,
        title: const Text('shopMy'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            product: loadedProducts[index],
          );
        },
      ),
    );
  }
}
