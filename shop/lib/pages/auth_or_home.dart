import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/products_overview_page.dart';

import '../models/auth.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    return Scaffold(
      body: FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            print("AQUI ${snapshot.error}");
            return const Center(
              child: Text('Ocorreu um erro'),
            );
          } else {
            return auth.isAuth ? ProductsOverviewPage() : AuthPage();
          }
        },
      ),
    );
  }
}
