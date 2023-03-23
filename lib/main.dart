// ignore_for_file: public_member_api_docs, sort_constructors_first, sized_box_for_whitespace
import 'dart:math';

import 'package:expence_planner_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Quicksand',
        shadowColor: Colors.black,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        dialogTheme: const DialogTheme(
          elevation: 5,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: const Color(0xff9c413e),
          tertiary: const Color(0xff4fd8eb),
          onPrimary: const Color(0xffffffff),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionsList = [];

  void _addNewTransaction(String titleTx, double amountTx, DateTime date) {
    final tx = Transaction(
      DateTime.now().toString(),
      titleTx,
      amountTx,
      date,
    );

    setState(() {
      _transactionsList.add(tx);
    });
  }

  void _editTransaction(
      Transaction tx, String editedTitle, double editedAmount) {
    setState(
      () {
        tx.amount = editedAmount;
        tx.title = editedTitle;
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactionsList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactionsList.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction() {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.all(20),
          title: const Text("Add new Transaction"),
          children: [
            NewTransaction(_addNewTransaction),
          ],
        );
      },
    );
  }

  void _refresh() {
    setState(() {
      _transactionsList.forEach(
        (element) {
          if (DateTime.now().difference(element.date).inDays >= 7) {
            _transactionsList.remove(element);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => _refresh(),
            icon: const Icon(Icons.refresh),
          )
        ],
        title: const Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(
                _transactionsList, _removeTransaction, _editTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 13,
        highlightElevation: 10,
        onPressed: () => _startAddNewTransaction(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
