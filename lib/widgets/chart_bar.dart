import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class ChartBar extends StatelessWidget {
  double _perCentOfTotal;
  double _totalSum;
  String _label;

  ChartBar(this._label, this._perCentOfTotal, this._totalSum);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('${_totalSum.toStringAsFixed(0)}\$'),
        LinearPercentIndicator(
          percent: _perCentOfTotal,
          width: 20,
        ),
        Text(_label),
      ],
    );
  }
}
