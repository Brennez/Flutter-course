import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge_item.dart';
import 'package:shop/models/products_list.dart';
import 'package:shop/utils/app_routes.dart';

import '../components/product_grid.dart';
import '../models/cart.dart';
import '../utils/light_theme.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightTheme.colorScheme.primary,
        title: const Text('shopMy'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_sharp),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text('Meus Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Mostrar Todos'),
              ),
            ],
            onSelected: (FilterOptions option) {
              setState(() {
                if (option == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.CART);
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
            builder: (context, cart, child) => BadgeItem(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
