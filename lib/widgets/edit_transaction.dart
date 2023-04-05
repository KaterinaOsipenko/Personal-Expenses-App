import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final Transaction _transaction;

  Transaction get transaction => _transaction;

  final Function _handlerEdit;

  const EditTransaction(this._transaction, this._handlerEdit, {super.key});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  late TextEditingController titleController;

  late TextEditingController amountController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.transaction.title);
    amountController =
        TextEditingController(text: widget._transaction.amount.toString());
    super.initState();
  }

  void submitData() {
    String editedTitle;
    double editedAmount;

    editedTitle = titleController.text.isEmpty
        ? widget.transaction.title
        : titleController.text;

    editedAmount = double.parse(amountController.text).isNaN ||
            double.parse(amountController.text).isNegative ||
            amountController.text.isEmpty
        ? widget.transaction.amount
        : double.parse(amountController.text);

    widget._handlerEdit(widget.transaction, editedTitle, editedAmount);

    Navigator.of(context).pop();
  }

  void _showDateEditor() {
    showDatePicker(
      context: context,
      initialDate: widget.transaction.date,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          widget.transaction.date = pickedDate;
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
              label: Text(widget.transaction.title),
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
              label: Text("${widget.transaction.amount}"),
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
              "Date: ${DateFormat.yMd().format(widget.transaction.date)}",
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
