import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/app.dart';
import 'package:provider/provider.dart';

import 'Utils/theme/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => ThemeNotifier(),
    child: const App(),
  ),);
}

