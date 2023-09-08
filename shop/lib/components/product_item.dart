import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/products_list.dart';

import '../exceptions/http_error.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  void _showConfirmationDialog(BuildContext context, Product product) {
    ProductList productList = Provider.of<ProductList>(context, listen: false);

    final msg = ScaffoldMessenger.of(context);

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Deseja remover esse produto da loja?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Sim',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Não',
            ),
          ),
        ],
      ),
    ).then((value) async {
      try {
        if (value ?? false) {
          await productList.removeProduct(product);
        }
      } on HttpError catch (error) {
        msg.showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
        ),
        title: Text(product.name),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product,
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 38, 75, 41),
                ),
              ),
              IconButton(
                onPressed: () => _showConfirmationDialog(context, product),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ));
  }
}
