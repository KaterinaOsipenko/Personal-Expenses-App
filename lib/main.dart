// ignore_for_file: public_member_api_docs, sort_constructors_first, sized_box_for_whitespace
import 'package:expence_planner_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
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
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        dialogTheme: const DialogTheme(
          shadowColor: Colors.black,
          elevation: 5,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: const Color(0xff75565b),
          tertiary: const Color(0xff795831),
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
  final List<Transaction> _transactionsList = [
    // Transaction(
    //   id: 'vf',
    //   title: 'Shoes',
    //   amount: 99.90,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'df',
    //   title: 'Food',
    //   amount: 25.00,
    //   date: DateTime.now(),
    // )
  ];

  void _addNewTransaction(String titleTx, double amountTx) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      title: titleTx,
      amount: amountTx,
      date: DateTime.now(),
    );

    setState(() {
      _transactionsList.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.all(10),
          title: const Text("Add new Transaction"),
          children: [
            NewTransaction(_addNewTransaction),
          ],
        );
      },
    );
    // showModalBottomSheet(
    //   context: ctx,

    //   builder: (_) {
    //     return GestureDetector(
    //       onTap: () {},
    //       behavior: HitTestBehavior.opaque,
    //       child: NewTransaction(_addNewTransaction),
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: const Card(
                elevation: 10,
                child: Text('CHART'),
              ),
            ),
            TransactionList(_transactionsList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 13,
        highlightElevation: 10,
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
