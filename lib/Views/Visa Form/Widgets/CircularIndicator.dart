import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularIndicator extends StatelessWidget {
  final RxString status;
  final int number;

  const CircularIndicator({
    Key? key,
    required this.status,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color backgroundColor;
      Color textColor;

      switch (status.value) {
        case 'completed':
          backgroundColor = const Color(0xFF5E5E5E);
          textColor = Colors.white;
          break;
        case 'in-progress':
          backgroundColor = const Color(0xFF2F80ED);
          textColor = Colors.white;
          break;
        default:
          backgroundColor = Colors.white;
          textColor = const Color(0xFF5E5E5E);
          break;
      }

      return CircleAvatar(
        radius: 20,
        backgroundColor: backgroundColor,
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 19,
            color: textColor,
          ),
        ),
      );
    });
  }
}
