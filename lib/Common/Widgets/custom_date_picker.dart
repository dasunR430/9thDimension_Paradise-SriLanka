import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatelessWidget {
  final String questionText;
  final String labelText;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController? controller;
  final bool isRequired;

  const CustomDatePickerField({
    super.key,
    required this.questionText,
    required this.labelText,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.controller,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              questionText,
              style: const TextStyle(fontSize: 16),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today), // Calendar icon
          ),
          readOnly: true, // To prevent manual input
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
            );
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
            if (controller != null) {
              controller!.text = formattedDate;
            }
                    },
        ),
      ],
    );
  }
}
