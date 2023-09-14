import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem Vindo, usuário'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
            ),
            title: Text('Loja'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.payment_rounded,
            ),
            title: Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.edit_note_sharp,
            ),
            title: Text('Gerenciar Produtos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS),
          ),
          const Spacer(),
          ListTile(
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text('Sair'),
              onTap: () {
                Provider.of<Auth>(
                  context,
                  listen: false,
                ).logout();

                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
              }),
        ],
      ),
    );
  }
}
