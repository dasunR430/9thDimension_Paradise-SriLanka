import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paradise_sri_lanka/Views/Authentication/Login/login_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Type%20Selection/visa_type_selection.dart';
import 'package:provider/provider.dart';
import 'Controllers/applicants_controller.dart';
import 'Utils/constants/text_strings.dart';
import 'Utils/theme/theme.dart';
import 'Utils/theme/theme_notifier.dart';
import 'Views/Applicants Screen/applicants_screen.dart';
import 'Views/Authentication/Register/register_screen.dart';
import 'Views/Visa Form/Sections/travel_history.dart';
import 'Views/Visa Form/form_screen.dart';
import 'Views/Visa Status Check/visa_status_check_screen.dart';
import 'Views/Visa Type Selection/visa_type_show.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    //Make the storage value for User on boarded false if it is null
    GetStorage().writeIfNull("IsOnboarded", false);
    final applicantsController = Get.put(ApplicantController());
    return GetMaterialApp(
      title: ConstantTexts.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      home: VisaTypeSelection(),
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