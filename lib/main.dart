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
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        textTheme: const TextTheme(
          labelSmall: TextStyle(
            fontSize: 8,
          ),
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

  bool _showChart = false;

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
    final appBar = AppBar(
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
    );

    final _txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.6,
      child: TransactionList(
          _transactionsList, _removeTransaction, _editTransaction),
    );

    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show chart"),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!_isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape) _txListWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : _txListWidget,
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
