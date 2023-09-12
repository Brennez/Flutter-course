import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/auth.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );

    final cart = Provider.of<Cart>(
      context,
      listen: true,
    );

    final auth = Provider.of<Auth>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              onPressed: () {
                product.toggleFavorite(auth.token ?? '');
              },
              icon: product.isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )
                  : const Icon(
                      Icons.favorite_border,
                    ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Cancelar',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
            icon: Icon(Icons.shopping_cart_rounded),
          ),
          subtitle: Text(
            '${cart.countSpecificItem(product.id)}x',
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
