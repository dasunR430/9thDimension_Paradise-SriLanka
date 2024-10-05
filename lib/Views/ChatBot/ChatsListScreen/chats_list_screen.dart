import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chat_list_controller.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';

import 'Widgets/chat_card.dart';
import 'Widgets/chatbot_appbar.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  final ChatListController controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverPersistentHeader(
              delegate: ChatBotAppBar(
                minHeight: 110.0,
                maxHeight: 300.0,
              ),
              pinned: true,
              floating: true,
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(()=>ListView.separated(
                    itemBuilder: (context, index) {
                      Chat chat = controller.chatList[index];
                      return ChatCard(chat: chat);
                    },
                    separatorBuilder: (context, index) =>
                        const Column(
                          children: [
                            SizedBox(height: 20),
                          ],
                        ),
                    itemCount: controller.chatList.length,
                  )),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: controller.onNewChatPressed,
        ));
  }
}


