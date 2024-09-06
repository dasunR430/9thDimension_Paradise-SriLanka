import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomDottedLine extends StatelessWidget {
  const CustomDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: 40,
      lineThickness: 4.0,
      dashLength: 12.0,
      dashColor: Colors.white,
      dashGapLength: 4.0,
    );
  }
}