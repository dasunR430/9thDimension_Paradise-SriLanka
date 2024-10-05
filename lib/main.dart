import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/app.dart';
import 'package:provider/provider.dart';

import 'Services/API/authenticate.dart';
import 'Services/local_database.dart';
import 'Utils/theme/theme_notifier.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await ParadiseAuthenticate.init();
  await LocalDatabase().initDatabase();
  runApp(
    ChangeNotifierProvider(
    create: (context) => ThemeNotifier(),
    child: const App(),
  ),);
}

