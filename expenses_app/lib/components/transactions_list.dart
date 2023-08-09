import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        ? Column(
            children: [
              const SizedBox(
                height: 20,
              ),
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
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              // ele pega a lista de transactions e itera pelo index
              final transaction = widget.transactions[index];

              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        child: Text(
                          'R\$ ${transaction.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: myTheme.textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(transaction.date),
                    style: myTheme.textTheme.titleSmall,
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          _showConfirmationDialog(context, transaction.id);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                      )),
                ),
              );
            });
  }
}
