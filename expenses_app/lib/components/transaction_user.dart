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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsList(transactions: transactions),
        TransactionForm(),
      ],
    );
  }
}
