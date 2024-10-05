import 'package:flutter/material.dart';

class CustomTextSelectionTheme {
  CustomTextSelectionTheme._();

  static final lightTextSelectionTheme = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue.withOpacity(0.3),
    selectionHandleColor: Colors.blue,
  );

  static final darkTextSelectionTheme = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue.withOpacity(0.3),
    selectionHandleColor: Colors.blue,
  );
}