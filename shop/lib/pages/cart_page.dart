import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final OrderList orderList = Provider.of(context);

    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Colors.grey,
                    label: FittedBox(
                      child: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const Spacer(),
                  CartButton(cart: cart, orderList: orderList)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  CartItemWidget(cartItem: items[index]),
            ),
          )
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.cart,
    required this.orderList,
  });

  final Cart cart;
  final OrderList orderList;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator(
            color: Colors.black,
          )
        : TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() => _isLoading = true);

                    await widget.orderList.addOrder(widget.cart);

                    widget.cart.clear();

                    setState(() => _isLoading = false);
                  },
            child: Text('COMPRAR'),
          );
  }
}
