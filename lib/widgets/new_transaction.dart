import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enetredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enetredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enetredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
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
            controller: titleController,
            onSubmitted: (_) => submitData(),
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
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
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.purple),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? "No date chosen"
                  : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
            ),
            AdaptiveFlatButton("Choose date", _showDatePicker),
          ],
        ),
        FilledButton.tonal(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.black12),
            elevation: const MaterialStatePropertyAll(5),
          ),
          onPressed: submitData,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
