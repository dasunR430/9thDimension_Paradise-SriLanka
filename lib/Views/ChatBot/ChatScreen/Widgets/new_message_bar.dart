import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chat_screen_controller.dart';
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
            Obx(() =>!controller.isGenerating.value ?  InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: controller.onMessageSendPressed ,
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
            )
              :
            const InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: null,
              child: Card(
                  elevation: 5,
                  shape: CircleBorder(),
                  color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                  )),
            ),)
          ],
        ),
      ),
    );
  }
}
