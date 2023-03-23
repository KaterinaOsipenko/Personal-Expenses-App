class Transaction {
  final String _id;
  String _title;
  double _amount;
  DateTime _date;

  get id => _id;

  get title => _title;

  set title(value) => _title = value;

  get amount => _amount;

  set amount(value) => _amount = value;

  get date => _date;

  set date(value) => _date = value;

  Transaction(
    this._id,
    this._title,
    this._amount,
    this._date,
  );
}
