import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/order_list.dart';

import '../components/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Future<void> _refreshOrders(BuildContext context) async {
    Provider.of<OrderList>(
      context,
      listen: false,
    ).loadorders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Pedidos'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrderList>(context, listen: false).loadorders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Ocorreu um erro'),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, child) {
                  return RefreshIndicator(
                    onRefresh: () => _refreshOrders(context),
                    child: ListView.builder(
                      itemCount: orders.itemsCount,
                      itemBuilder: (context, index) {
                        return OrderWidget(
                          order: orders.items[index],
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
