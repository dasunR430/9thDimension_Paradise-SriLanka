class Chat{
  late int chatId;
  late String? sessionId;
  late String title;
  late String message;
  late DateTime dateTime;

  Chat({this.chatId=0, this.sessionId, this.title = "New Chat", this.message = "", DateTime? dateTime,}){
    if(dateTime == null){
      this.dateTime = DateTime.now();
    }
    else{
      this.dateTime = dateTime;
    }
  }
  
  Chat.fromJson(Map<String, dynamic> json){
    chatId = json['chatId'];
    sessionId = json['sessionId'];
    title = json['title'];
    message = json['message'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);
  }
  
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['sessionId'] = sessionId;
    data['title'] = title;
    data['message'] = message;
    data['dateTime'] = dateTime.millisecondsSinceEpoch;
    return data;
  }

}