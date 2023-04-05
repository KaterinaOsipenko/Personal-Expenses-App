import 'dart:math';

import 'package:expence_planner_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'edit_transaction.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;

  final Function handlerRemove;

  final Function handlerEdit;

  const TransactionItem(
      {required this.handlerEdit,
      required this.handlerRemove,
      required Key key,
      required this.transaction})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availiableColors = [Colors.red, Colors.pink, Colors.amber];

    _bgColor = availiableColors[Random().nextInt(3)];
    super.initState();
  }

  showEditTransaction(String id, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text("Edit Transaction"),
          titlePadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.all(10),
          children: [
            EditTransaction(widget.transaction, widget.handlerEdit),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _bgColor,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                "${widget.transaction.amount.toStringAsFixed(2)}\$",
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.MMMMEEEEd().format(widget.transaction.date),
          style:
              TextStyle(fontSize: 18 * MediaQuery.of(context).textScaleFactor),
        ),
        trailing: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => widget.handlerRemove(widget.transaction.id),
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () =>
                    showEditTransaction(widget.transaction.id, context),
                icon: const Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
