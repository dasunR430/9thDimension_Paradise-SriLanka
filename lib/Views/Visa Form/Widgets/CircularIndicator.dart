import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final String status;
  final int number;

  const CircularIndicator({
    super.key,
    required this.status,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    switch (status) {
      case 'done':
        backgroundColor = const Color(0xFF5E5E5E);
        break;
      case 'current':
        backgroundColor = const Color(0xFF2F80ED);
        break;
      default:
        backgroundColor = Colors.white;
        break;
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: backgroundColor,
      child: Text(
        number.toString(),
        style: TextStyle(
          fontSize: 19,
          color: status == 'next' ? const Color(0xFF5E5E5E) : Colors.white,
        ),
      ),
    );
  }
}
