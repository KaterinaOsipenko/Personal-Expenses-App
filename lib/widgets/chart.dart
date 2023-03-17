import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactionList;

  Chart(this._transactionList);

  List<Map<String, Object>> get _groupedTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0;
        for (var tx in _transactionList) {
          if (tx.date.day == weekDay.day &&
              tx.date.month == weekDay.month &&
              tx.date.year == weekDay.year) {
            totalSum += tx.amount;
          }
        }
        return {
          "day": DateFormat.E().format(weekDay).substring(0, 2),
          "sum": totalSum
        };
      },
    );
  }

  double get _totalSum {
    return _groupedTransactionsValues.fold(
      0.0,
      (sum, element) {
        return sum + (element["sum"] as double);
      },
    );
  }

  List<Widget> _createBars() {
    List<Widget> bars = [];

    for (var tx in _groupedTransactionsValues) {
      bars.add(
        Flexible(
          fit: FlexFit.tight,
          child: ChartBar(tx["day"].toString(), (tx["sum"] as double),
              _totalSum == 0.0 ? 0.0 : (tx["sum"] as double) / _totalSum),
        ),
      );
    }
    return bars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _createBars(),
        ),
      ),
    );
  }
}
