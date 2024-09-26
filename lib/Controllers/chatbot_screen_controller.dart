import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/Helpers/chatbots.dart';

class ChatScreenController extends GetxController {
  final Chat chat;

  ChatScreenController({required this.chat});

  static final ChatScreenController _chatbotController = Get.find();
  static ChatScreenController instance = _chatbotController;

  final TextEditingController newMessageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<String> bots = ChatBots.botNames;

  List<ChatMessage> chatMessages = List.generate(
      100,
      (index) => ChatMessage(
            message: "Hello",
            dateTime: DateTime.now(),
            sender: index % 2 == 0 ? 'Me' : 'Trip Specialist',
          ));

  RxInt selectedMode = 0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
    });
  }

  void changeMode(index) {
    selectedMode.value = index;
  }
}
