import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/order_list.dart';
import '../models/cart.dart';
import '../models/products_list.dart';

import '../pages/auth_or_home.dart';
import '../pages/product_form_page.dart';
import '../pages/products_page.dart';
import '../pages/cart_page.dart';
import '../pages/orders_page.dart';
import '../pages/product_detail_page.dart';

import '../utils/app_routes.dart';
import '../utils/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (context) => ProductList('', []),
          update: (context, auth, previous) {
            return ProductList(
              auth.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (context) => OrderList('', []),
          update: (context, auth, previous) {
            return OrderList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopMy',
        theme: lightTheme,
        routes: {
          AppRoutes.AUTH_OR_HOME: (context) => AuthOrHome(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailPage(),
          AppRoutes.CART: (context) => CartPage(),
          AppRoutes.ORDERS: (context) => OrdersPage(),
          AppRoutes.PRODUCTS: (context) => ProductsPage(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormPage(),
        },
      ),
    );
  }
}
