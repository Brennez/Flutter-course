import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nenhuma transação cadastrada!',
                  style: myTheme.textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * .3,
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                // ele pega a lista de transactions e itera pelo index
                final transaction = transactions[index];

                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: myTheme.colorScheme.primary,
                        ),
                        child: Text(
                          'R\$ ${transaction.value.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: myTheme.textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            DateFormat('d MMM y').format(transaction.date),
                            style: myTheme.textTheme.titleSmall,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
