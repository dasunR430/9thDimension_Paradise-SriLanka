import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/app.dart';
import 'package:provider/provider.dart';

import 'Utils/theme/theme_notifier.dart';
import 'Views/Gallery/gallery_screen.dart';
import 'Views/Home/home_screen.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//     create: (context) => ThemeNotifier(),
//     child: const App(),
//   ),);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paradise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),

    );
  }
}
