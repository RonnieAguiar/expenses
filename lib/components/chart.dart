import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenteTransactions;

  const Chart(this.recenteTransactions, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recenteTransactions.length; i++) {
        bool sameDay = recenteTransactions[i].date.day == weekDay.day;
        bool sameMonth = recenteTransactions[i].date.month == weekDay.month;
        bool sameYear = recenteTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recenteTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupTransactions.fold(0.0, (sum, tr) => sum + tr['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactions
              .map((tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: tr['day'],
                      value: tr['value'],
                      percentage: _weekTotalValue == 0
                          ? 0
                          : tr['value'] / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
