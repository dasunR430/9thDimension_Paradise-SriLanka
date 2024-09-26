class ChatMessage{
  late final String message;
  late final String sender;
  late final DateTime dateTime;

  ChatMessage({required this.message, required this.sender, required this.dateTime});

  ChatMessage.fromJson(Map<String, dynamic> json){
    message = json['message'];
    sender = json['sender'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['sender'] = sender;
    data['timestamp'] = dateTime.millisecondsSinceEpoch;
    return data;
  }
}