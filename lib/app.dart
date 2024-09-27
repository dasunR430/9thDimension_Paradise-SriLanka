import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/ChatScreen/chatbot_chat_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';
import 'package:provider/provider.dart';
import 'Utils/constants/text_strings.dart';
import 'Utils/theme/theme.dart';
import 'Utils/theme/theme_notifier.dart';
import 'Views/Applicants Screen/applicants_screen.dart';
import 'Views/Authentication/Login/login_screen.dart';
import 'Views/ChatBot/ChatsListScreen/chats_list_screen.dart';
import 'Views/Visa Portal/visa_portal_screen.dart';
import 'Views/Visa Type Selection/visa_type_selection_screen.dart';


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
      home: VisaPortalScreen(),
    );
  }
}

