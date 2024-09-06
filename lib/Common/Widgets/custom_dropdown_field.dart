import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String questionText;
  final String labelText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final TextEditingController? controller;
  final bool isRequired;

  const CustomDropdownField({
    super.key,
    required this.questionText,
    required this.labelText,
    required this.items,
    this.onChanged,
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
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? value) {
            if (controller != null) {
              controller!.text = value ?? '';
            }
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
