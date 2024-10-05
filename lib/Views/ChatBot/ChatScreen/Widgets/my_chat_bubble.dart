import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';

class MyChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  const MyChatBubble({
    super.key, required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15).copyWith(
                bottomRight: const Radius.circular(0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Text(
                chatMessage.message,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5), // Adds spacing between message and time
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "${chatMessage.dateTime.hour<10 ? "0": ""}${chatMessage.dateTime.hour}:${chatMessage.dateTime.minute<10 ? "0": ""}${chatMessage.dateTime.minute}",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}