import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Utils/constants/text_strings.dart';
import 'Utils/theme/theme.dart';
import 'Utils/theme/theme_notifier.dart';
import 'Views/Visa Portal/visa_portal_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    //Make the storage value for User on boarded false if it is null
    GetStorage().writeIfNull("IsOnboarded", false);
    return GetMaterialApp(
      title: ConstantTexts.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      home: const VisaPortalScreen(),
      // const Selector()
    );
  }
}

// class Selector extends StatelessWidget {
//   const Selector({super.key});
//   @override
//   Widget build(BuildContext context) {
//     if(GetStorage().read("IsOnboarded") == true)
//     {
//       User? fireBaseUser = FirebaseAuthentication().currentUser;
//       return fireBaseUser == null ? const LoginScreen() : NavigationScreen();
//     }
//     return OnboardingScreen();
//   }
// }