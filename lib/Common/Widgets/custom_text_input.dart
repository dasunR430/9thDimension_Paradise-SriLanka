import 'package:flutter/material.dart';

class CustomTextInputField extends StatelessWidget {
  final String questionText;
  final String labelText;
  final int maxLines;
  final TextEditingController? controller;
  final bool isRequired;

  const CustomTextInputField({
    super.key,
    required this.questionText,
    required this.labelText,
    this.maxLines = 1,
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
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}