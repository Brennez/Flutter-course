import 'dart:convert';
import 'dart:math';
import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/utils/theme.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/components/transaction_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/transactions_list.dart';
import 'models/transaction.dart';
import 'utils/api.dart';
import 'utils/shared_consts.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _loadTransactions();
    });
  }

  bool _showChart = true;

  Future<void> _loadTransactions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String transactionJson =
        _prefs.getString(SharedConsts.transactionKey) ?? '[]';

    List<dynamic> transactionData = json.decode(transactionJson);

    setState(() {
      transactions = transactionData
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    });
  }

  Future<void> _saveTransactions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    String transactionJson = json.encode(transactions);

    await _prefs.setString(SharedConsts.transactionKey, transactionJson);
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      transactions.add(newTransaction);
      _saveTransactions();
    });

    _closeTransactionFormModal(context);
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
          onCloseModal: _closeTransactionFormModal,
        );
      },
    );
  }

  _closeTransactionFormModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    AppBar appBar = AppBar(
      backgroundColor: myTheme.colorScheme.primary,
      title: Text(
        'Minhas Despesas',
        style: myTheme.textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(
              _showChart ? Icons.list_alt_rounded : Icons.bar_chart_rounded,
              size: 25,
              color: Colors.white,
            ),
          ),
        IconButton(
          onPressed: () {
            _openTransactionFormModal(context);
          },
          icon: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
      ],
    );

    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showChart || !isLandscape)
                SizedBox(
                  height: avaliableHeight * (isLandscape ? .7 : .3),
                  child: Chart(recentTransactions: _recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                SizedBox(
                  height: avaliableHeight * (isLandscape ? 1 : .6),
                  child: TransactionsList(
                      transactions: transactions,
                      removeTransaction: _removeTransaction),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTransactionFormModal(context);
        },
        backgroundColor: myTheme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
