import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:paradise_sri_lanka/Utils/helpers/text_formating.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/Helpers/chatbots.dart';

class BotChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  const BotChatBubble({
    super.key, required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            ChatBots.getBotImage(chatMessage.sender),
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:HelperFunctions.screenWidth() * 0.7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : ChatBots.getBotColor(chatMessage.sender).withOpacity(0.09),
                  borderRadius: BorderRadius.circular(15).copyWith(
                    topLeft: const Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatMessage.sender,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ChatBots.getBotColor(chatMessage.sender), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextFormating.getBoldStyledText(chatMessage.message, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5), // Adds spacing between message and time
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "${chatMessage.dateTime.hour<10 ? "0": ""}${chatMessage.dateTime.hour}:${chatMessage.dateTime.minute<10 ? "0": ""}${chatMessage.dateTime.minute}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
