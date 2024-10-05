import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/chat_screen_controller.dart';
import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Services/local_database.dart';
import 'package:paradise_sri_lanka/Views/ChatBot/ChatScreen/chat_screen.dart';

class ChatListController extends GetxController {
  static final ChatListController _chatListController = Get.find();
  static ChatListController get instance => _chatListController;

  RxList<Chat> chatList = List<Chat>.empty(growable: true).obs;

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _getChatList();
    });
    super.onInit();
  }

  void onChatCardPressed(Chat chat) async {
    await Get.to(ChatBotChatScreen(
      chat: chat,
    ));
    _sortChatList();
    update([chat.chatId]);
    Get.delete<ChatScreenController>();
  }

  void onNewChatPressed() async {
    Chat chat = Chat();
    await Get.to(ChatBotChatScreen(
      chat: chat,
    ));
    _getChatList();
    Get.delete<ChatScreenController>();
  }

  void _getChatList() async {
    chatList.value = await LocalDatabase().getChats();
    _sortChatList();
  }

  void _sortChatList() {
    chatList.sort((a, b) =>
        b.dateTime.compareTo(a.dateTime));
  }

}
