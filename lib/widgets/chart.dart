import 'dart:ffi';

import 'package:expence_planner_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import 'package:expence_planner_app/models/transaction.dart';
import 'package:flutter/material.dart';

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

  List<Widget> _createBars() {
    List<Widget> bars = [];
    var totalSum;

    for (var tx in _transactionList) {
      totalSum += tx.amount;
    }

    for (var tx in _groupedTransactionsValues) {
      bars.add(
        ChartBar(
            tx["day"].toString(),
            (double.parse(tx["sum"].toString()) / totalSum * 100),
            double.parse(tx["sum"].toString())),
      );
    }

    return bars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _createBars(),
      ),
    );
  }
}
