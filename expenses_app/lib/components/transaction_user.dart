import 'dart:math';

import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

import '../utils/api.dart';
import 'transaction_form.dart';
import 'transactions_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsList(transactions: transactions),
        TransactionForm(onSubmit: _addTransaction),
      ],
    );
  }
}
