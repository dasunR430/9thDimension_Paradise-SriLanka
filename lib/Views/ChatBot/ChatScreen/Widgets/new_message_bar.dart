import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Controllers/chatbot_screen_controller.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

class NewMessageBar extends StatelessWidget {
  final ChatScreenController controller;
  NewMessageBar({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: MediaQuery.of(context)
          .viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: isDark ? Colors.white10 : Colors.white,
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: controller.newMessageController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: () {
                //send message
              },
              child: const Card(
                  elevation: 5,
                  shape: CircleBorder(),
                  color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
