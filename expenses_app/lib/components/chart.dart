import 'package:expenses_app/components/chart_bar.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Pega o dia de hoje e subtrai o index, por exemplo: Segunda - Index[0] = Domingo
      final weekDay = DateTime.now().subtract(Duration(days: index));

      // Ele usa o pacote INTL pra formatar a o DateTime vindo do weekDay pegando só a primeira letra
      // Que vai gerar as siglas do dia da semana, por exemplo: M, T, W, TH...
      final dayAcronym = DateFormat.E().format(weekDay)[0];

      double totSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totSum += recentTransactions[i].value;
        }
      }

      // print(dayAcronym);
      // print(totSum);

      return {
        'day': dayAcronym,
        'value': totSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (acumulate, transaction) {
      return acumulate + (transaction['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: double.parse(transaction['value'].toString()),
                percentage: (transaction['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
