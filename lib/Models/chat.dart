class Chat{
  String id;
  String title;
  String message;
  late DateTime dateTime;

  Chat({this.id="New", this.title = "New Chat", this.message = "", DateTime? dateTime,}){
    if(dateTime == null){
      this.dateTime = DateTime.now();
    }
    else{
      this.dateTime = dateTime;
    }
  }

}