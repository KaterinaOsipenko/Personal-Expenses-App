import 'package:expence_planner_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;

  final Function handlerRemove;

  final Function handlerEdit;

  const TransactionList(
      this.transactionsList, this.handlerRemove, this.handlerEdit,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactionsList.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Text(
                      "There are no transactions!",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                    handlerEdit: handlerEdit,
                    handlerRemove: handlerRemove,
                    key: ValueKey(transactionsList[index].id),
                    transaction: transactionsList[index]);
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
