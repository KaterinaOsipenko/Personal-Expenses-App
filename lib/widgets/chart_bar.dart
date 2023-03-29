import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double _perCentOfTotal;
  final double _totalSum;
  final String _label;

  const ChartBar(this._label, this._totalSum, this._perCentOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        return Column(
          children: [
            SizedBox(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$$_totalSum",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            SizedBox(
              height: contraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: contraints.maxHeight * 0.6,
              width: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: _perCentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: contraints.maxHeight * 0.05,
            ),
            SizedBox(
                height: contraints.maxHeight * 0.10,
                child: FittedBox(
                    child: Text(
                  _label,
                  style: Theme.of(context).textTheme.labelSmall,
                ))),
          ],
        );
      },
    );
  }
}
