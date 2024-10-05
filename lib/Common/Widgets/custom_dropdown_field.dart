import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:tuple/tuple.dart';


class CustomDropdownField extends StatelessWidget {
  final String questionText;
  final String labelText;
  final List<Tuple2<String, String>> items;
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
            labelText: items.firstWhere((item) => item.item1 == controller?.text, orElse: () => const Tuple2('', 'Option')).item2,
            border: const OutlineInputBorder(),
          ),
          items: items.map((Tuple2<String, String> pair) {
            return DropdownMenuItem<String>(
              value: pair.item1,
              child: SizedBox(width: HelperFunctions.screenWidth()-150, child: Text(pair.item2, maxLines: 3, style: const TextStyle(overflow: TextOverflow.ellipsis, ))),
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
