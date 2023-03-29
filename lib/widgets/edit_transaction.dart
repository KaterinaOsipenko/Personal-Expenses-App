import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final List<Transaction> _transactionsList;
  final String _id;
  final Function _handlerEdit;

  const EditTransaction(this._transactionsList, this._id, this._handlerEdit,
      {super.key});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  late TextEditingController titleController;

  late TextEditingController amountController;

  @override
  void initState() {
    titleController = TextEditingController(text: _transaction.title);
    amountController =
        TextEditingController(text: _transaction.amount.toString());
    super.initState();
  }

  Transaction get _transaction {
    Transaction transaction = widget._transactionsList
        .firstWhere((element) => element.id == widget._id);
    return transaction;
  }

  void submitData() {
    String editedTitle;
    double editedAmount;

    editedTitle = titleController.text.isEmpty
        ? _transaction.title
        : titleController.text;

    editedAmount = double.parse(amountController.text).isNaN ||
            double.parse(amountController.text).isNegative ||
            amountController.text.isEmpty
        ? _transaction.amount
        : double.parse(amountController.text);

    widget._handlerEdit(_transaction, editedTitle, editedAmount);

    Navigator.of(context).pop();
  }

  void _showDateEditor() {
    showDatePicker(
      context: context,
      initialDate: _transaction.date,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _transaction.date = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: TextField(
            onSubmitted: (_) => submitData(),
            controller: titleController,
            decoration: InputDecoration(
              label: Text(_transaction.title),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => submitData(),
            decoration: InputDecoration(
              label: Text("${_transaction.amount}"),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date: ${DateFormat.yMd().format(_transaction.date)}",
            ),
            TextButton(
              onPressed: _showDateEditor,
              child: const Text("Edit Date"),
            )
          ],
        ),
        FilledButton.tonal(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.black12),
            elevation: const MaterialStatePropertyAll(5),
          ),
          onPressed: submitData,
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
