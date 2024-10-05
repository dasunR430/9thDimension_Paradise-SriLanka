class ChatMessage{
  late final int chatId;
  late final String message;
  late final String sender;
  late final DateTime dateTime;

  ChatMessage({required this.chatId, required this.message, required this.sender, required this.dateTime});

  ChatMessage.fromJson(Map<String, dynamic> json){
    chatId = json['chatId'];
    message = json['message'];
    sender = json['sender'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['message'] = message;
    data['sender'] = sender;
    data['dateTime'] = dateTime.millisecondsSinceEpoch;
    return data;
  }
}