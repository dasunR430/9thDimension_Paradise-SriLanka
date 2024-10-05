import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';
import 'package:paradise_sri_lanka/Services/connections.dart';
import 'package:paradise_sri_lanka/Services/local_database.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/Helpers/chatbots.dart';

class ChatScreenController extends GetxController {
  final Chat chat;

  ChatScreenController({required this.chat});

  static final ChatScreenController _chatbotController = Get.find();
  static ChatScreenController instance = _chatbotController;

  final TextEditingController newMessageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<String> bots = ChatBots.botNames;

  List<ChatMessage> chatMessages = List.empty(growable: true);

  RxInt selectedMode = 0.obs;
  RxBool isGenerating = false.obs;

  @override
  void onInit() async{
    super.onInit();

    await _getChatMessages();

    if(chatMessages.length > 1){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  void changeMode(index) {
    selectedMode.value = index;
  }

  void onMessageSendPressed() async {
    String message = newMessageController.text;
    message = message.trim();
    if(message.isEmpty){
      return;
    }
    if(chat.chatId == 0){
      int? chatId = await LocalDatabase().createChat();
      if(chatId != null){
        chat.chatId = chatId;
        print(chatId);
      }
      else{
        return;
      }
    }

    bool isFirstMessage = false;
    if(chat.sessionId == null){
      isFirstMessage = true;
    }

    ChatMessage myChatMessage = ChatMessage(
      chatId: chat.chatId,
      message: message,
      dateTime: DateTime.now(),
      sender: 'Me',
    );
    chatMessages.add(myChatMessage);
    LocalDatabase().insertChatMessage(myChatMessage);
    newMessageController.clear();
    updateMessageList();

    try{
      isGenerating.value = true;
      Map<String, String> response = await Connections.sendMessageToChatbot(
          message, selectedMode.value.isEven, isFirstMessage, !isFirstMessage ? chat.sessionId : null);

      ChatMessage responseChatMessage = ChatMessage(
        chatId: chat.chatId,
        message: response['response']!,
        dateTime: DateTime.now(),
        sender: response['selected_agent'] ?? "General",
      );

      LocalDatabase().insertChatMessage(responseChatMessage);
      chatMessages.add(responseChatMessage);
      updateMessageList();
      if(isFirstMessage){
        chat.title = response['topic'] ?? "New Chat";
        chat.sessionId = response['sessionId'];
        update(["chatTitle"]);
      }
      chat.message = responseChatMessage.message;
      chat.dateTime = responseChatMessage.dateTime;
      LocalDatabase().updateChat(chat);
      isGenerating.value = false;
    }
    catch(e){
      ChatMessage chatMessage = ChatMessage(
        chatId: chat.chatId,
        message: "Sorry, We are unable to process your request at the moment. Please try again.",
        dateTime: DateTime.now(),
        sender: 'General',
      );
      LocalDatabase().insertChatMessage(chatMessage);
      chatMessages.add(chatMessage);
      updateMessageList();
      chat.message = chatMessage.message;
      chat.dateTime = chatMessage.dateTime;
      LocalDatabase().updateChat(chat);
      isGenerating.value = false;
    }
  }

  void updateMessageList(){
    update(["chatMessagesList"]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  Future<void> _getChatMessages() async {
    chatMessages = List.empty(growable: true);

    chatMessages.add(ChatMessage(
      chatId: chat.chatId,
      message: """Hello and welcome! 😊 I'm part of your travel assistant team, and each of us specializes in a different area to make your journey unforgettable:


🏨**Stay Specialist:** Ready to help you find the perfect place to stay.

🚕**Transport Specialist:** Know all about taxis, buses, and airbuses to get you where you need to go.

✈️**Tour Agent:** At your service for all your travel arrangements.

🏛️**Place Specialist:** Let me guide you to the best attractions and experiences.

🛍️**Shop Specialist:** Need shopping tips or deals? I'm here for you.

🤖**General (that's me!):** I'm here to answer any other questions you may have.


How can we assist you today?""",
      dateTime: DateTime.now(),
      sender: 'General',
    ));

    if(chat.chatId != 0) {
      List<ChatMessage> messages = await LocalDatabase().getChatMessages(chat.chatId);
      chatMessages.addAll(messages);
    }
  }
}
