import 'package:expenses_app/components/transaction_item.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/utils/theme.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactions;

  final Function(String) removeTransaction;
  const TransactionsList(
      {super.key, required this.transactions, required this.removeTransaction});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  Future<void> _showConfirmationDialog(BuildContext context, String id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmação',
                style: myTheme.textTheme.titleLarge!.copyWith(
                  color: myTheme.primaryColor,
                )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Deseja excluir esta transação?',
                    style: myTheme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancelar',
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
              ),
              TextButton(
                child: const Text(
                  'Confirmar',
                ),
                onPressed: () {
                  widget.removeTransaction(id);
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    'Nenhuma transação cadastrada!',
                    style: myTheme.textTheme.displayMedium,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              // ele pega a lista de transactions e itera pelo index
              final transaction = widget.transactions[index];
              // final id = widget.transactions[index].id;

              return TransactionItem(
                  key: GlobalObjectKey(transaction),
                  transaction: transaction,
                  showConfirmation: (context, id) {
                    _showConfirmationDialog(context, id);
                  });
            });
  }
}
