import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chatbot_screen_controller.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

import 'Widgets/bot_chat_bubble.dart';
import 'Widgets/my_chat_bubble.dart';
import 'Widgets/new_message_bar.dart';

class ChatBotChatScreen extends StatelessWidget {
  final Chat chat;
  late final ChatScreenController controller;

  ChatBotChatScreen({super.key, required this.chat}){
    controller = Get.put(ChatScreenController(chat: chat));
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          chat.title,
          style: Theme.of(context).textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                //TODO: Implement info dialog
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Obx(
              () => FlutterToggleTab(
                width: 60,
                borderRadius: 30,
                selectedBackgroundColors: const [Colors.blue],
                unSelectedBackgroundColors: isDark ? [Colors.grey[800]!] : [Colors.white],
                selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                unSelectedTextStyle: isDark ? const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold) : const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                labels: const ["Speedy", "Accurate"],
                selectedLabelIndex: controller.changeMode,
                selectedIndex: controller.selectedMode.value,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                controller: controller.scrollController,
                itemBuilder: (context, index) {
                  ChatMessage chatMessage = controller.chatMessages[index];
                  return chatMessage.sender == 'Me'
                      ? MyChatBubble(chatMessage: chatMessage)
                      : BotChatBubble(chatMessage: chatMessage);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: controller.chatMessages.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NewMessageBar(controller: controller),
    );
  }
}
