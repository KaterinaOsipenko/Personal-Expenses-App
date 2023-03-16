import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;

  TransactionList(this.transactionsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactionsList.isEmpty
          ? Column(
              children: [
                Text(
                  "There are no transactions!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.tertiary,
                            style: BorderStyle.solid,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "${transactionsList[index].amount.toStringAsFixed(2)}\$",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionsList[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            DateFormat.MMMMEEEEd()
                                .add_Hm()
                                .format(transactionsList[index].date),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
