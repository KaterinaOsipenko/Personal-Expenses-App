import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class ChartBar extends StatelessWidget {
  final double _perCentOfTotal;
  final double _totalSum;
  final String _label;

  ChartBar(this._label, this._totalSum, this._perCentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text("\$$_totalSum"),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 15,
          child: Stack(
            children: [
              FractionallySizedBox(
                heightFactor: _perCentOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(_label),
      ],
    );
  }
}
