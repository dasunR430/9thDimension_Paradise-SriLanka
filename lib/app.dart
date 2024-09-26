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
import 'Views/Visa Type Selection/question_screen.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: ConstantTexts.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: ChatListScreen(),
    );
  }
}

