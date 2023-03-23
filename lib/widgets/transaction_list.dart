import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'chart.dart';
import 'edit_transaction.dart';
import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;

  final Function handlerRemove;

  final Function handlerEdit;

  TransactionList(this.transactionsList, this.handlerRemove, this.handlerEdit);

  _showEditTransaction(String id, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Edit Transaction"),
          titlePadding: EdgeInsets.all(15),
          contentPadding: EdgeInsets.all(10),
          children: [
            EditTransaction(transactionsList, id, handlerEdit),
          ],
        );
      },
    );
  }

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
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "${transactionsList[index].amount.toStringAsFixed(2)}\$",
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactionsList[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.MMMMEEEEd()
                          .format(transactionsList[index].date),
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () =>
                                handlerRemove(transactionsList[index].id),
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () => _showEditTransaction(
                                transactionsList[index].id, context),
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
