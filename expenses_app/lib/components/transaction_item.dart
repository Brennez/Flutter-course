import 'dart:math';

import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/theme.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function(BuildContext, String) showConfirmation;

  const TransactionItem({
    required Key key,
    required this.transaction,
    required this.showConfirmation,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  final colors = [
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text(
                'R\$ ${widget.transaction.value.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: myTheme.textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.transaction.date),
          style: myTheme.textTheme.titleSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () {
                  widget.showConfirmation(context, widget.transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[400],
                ),
                label: Text(
                  'Excluir',
                  style: myTheme.textTheme.displaySmall!.copyWith(
                    color: Colors.red,
                  ),
                ))
            : IconButton(
                onPressed: () {
                  widget.showConfirmation(context, widget.transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[400],
                )),
      ),
    );
  }
}
