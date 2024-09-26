import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chatbot_screen_controller.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/ChatScreen/chatbot_chat_screen.dart';

class ChatListController extends GetxController{

  static final ChatListController _chatListController = Get.find();
  static ChatListController get instance => _chatListController;

  RxList<Chat> chatList = List.generate(100, (index) => Chat(
    title: "Chat Message",
    message: "Last Message kasjflkajflkas f lasldfjalf sa klfjlas flkasfjlka jlfdksajlasjfl kjjlkl kjkljkljsladkfj kjlkfsd lskjfkljfl",
  )).obs;

  void onChatCardPressed(Chat chat) async{
    await Get.to(ChatBotChatScreen(chat: chat,));
    update([chat.id]);
    Get.delete<ChatScreenController>();
  }
}