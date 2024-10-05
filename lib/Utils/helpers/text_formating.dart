import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

class TextFormating{
  static TextSpan getBoldStyledText(String text, BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);

    final List<TextSpan> spans = [];
    final parts = text.split('**');

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        spans.add(
          TextSpan(
            text: parts[i],
            style: Theme.of(context)
                .textTheme
                .bodySmall?.copyWith(
              color: isDark ? Colors.white : Colors.black,
          ),
        ),
        );
      } else {
        // Bold text
        spans.add(
          TextSpan(
            text: parts[i],
            style: Theme.of(context)
                .textTheme
                .bodySmall?.copyWith(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 15
            ),
          ),
        );
      }
    }

    return TextSpan(children: spans);
  }
}