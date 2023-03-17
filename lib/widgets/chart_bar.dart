import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class ChartBar extends StatelessWidget {
  final double _perCentOfTotal;
  final double _totalSum;
  final String _label;

  ChartBar(this._label, this._totalSum, this._perCentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${_totalSum.toStringAsFixed(0)}\$'),
        const SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: LinearPercentIndicator(
            width: 140.0,
            lineHeight: 14.0,
            percent: _perCentOfTotal,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
        ),
        // Container(
        //   height: 60,
        //   decoration: BoxDecoration(
        //     border: Border.all(width: 1),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   width: 15,
        //   child: Stack(
        //     children: [
        //       FractionallySizedBox(
        //         heightFactor: _perCentOfTotal,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: Theme.of(context).colorScheme.secondary,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 4,
        ),
        Text(_label),
      ],
    );
  }
}
