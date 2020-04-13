import 'package:flutter/material.dart';

class VerticalDashLine extends StatelessWidget {
  final Color color;

  const VerticalDashLine({this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.constrainHeight();
        final dashWidth = 4.0;
        final dashCount = (height / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: 1,
              height: dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
        );
      },
    );
  }
}