import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chat_list_controller.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final ChatListController controller = ChatListController.instance;

  ChatCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => controller.onChatCardPressed(chat),
        child: GetBuilder<ChatListController>(
          id: chat.chatId,
          builder: (_) => Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage:
                    AssetImage("assets/images/bot_images/general.png"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              chat.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            getChatTimeString(chat.dateTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          chat.message,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String getChatTimeString(DateTime dateTime) {
    if (dateTime.day == DateTime.now().day) {
      return "${dateTime.hour < 10 ? "0" : ""}${dateTime.hour}:${dateTime.minute < 10 ? "0" : ""}${dateTime.minute}";
    } else if (dateTime.day == DateTime.now().day - 1) {
      return "Yesterday";
    } else if (dateTime.day > DateTime.now().day - 7) {
      switch (dateTime.weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
        default:
          return "";
      }
    } else {
      return "${dateTime.day < 10 ? "0" : ""}${dateTime.day}/${dateTime.month < 10 ? "0" : ""}${dateTime.month}/${dateTime.year}";
    }
  }
}
