import 'package:paradise_sri_lanka/Models/chat.dart';
import 'package:paradise_sri_lanka/Models/chat_message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  late Database _database;
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  LocalDatabase._internal();

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'paradise_sl.db');

    _database =
    await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE Chat(
            chatId INT PRIMARY KEY,
            sessionId TEXT,
            userId TEXT,
            title TEXT,
            message TEXT,
            dateTime INT
          );
        ''');
      await db.execute('''
          CREATE TABLE ChatMessage(
            chatId INT,
            dateTime INT,
            message TEXT,
            sender TEXT,
            PRIMARY KEY (chatId, dateTime),
            FOREIGN KEY (chatId) REFERENCES Chat(chatId)
          );
        ''');
    });

    return _database;
  }

  Future<int?> createChat() async {
    final result = await _database.rawQuery('SELECT MAX(chatId) AS maxId FROM Chat');
    int chatId = (result.first['maxId'] as int? ?? 0) + 1;

    int insertResult = await _database.insert(
      'Chat',
      {
        'chatId': chatId,  // Incremented chatId
        'title': "New Chat",
        'sessionId': null,
        'message': "",
        'dateTime': DateTime.now().millisecondsSinceEpoch
      },
    );
    if(insertResult != 0){
      return chatId;
    }
    return null;
  }

  Future<int> updateChat(Chat chat) async {
    int updateResult = await _database.update(
      'Chat',
      chat.toJson(),
      where: 'chatId = ?',
      whereArgs: [chat.chatId],
    );
    return updateResult;
  }

  Future<bool> insertChatMessage(ChatMessage chatMessage) async {
    int insertResult = await _database.insert(
      'ChatMessage',
      chatMessage.toJson(),
    );
    if(insertResult != 0){
      return true;
    }
    return false;
  }

  Future<List<Chat>> getChats() async {
    List<Map<String, dynamic>> results = await _database.query('Chat');
    return results.isNotEmpty
        ? results.map((data) => Chat.fromJson(data)).toList()
        : [];
  }

  Future<List<ChatMessage>> getChatMessages(int chatId) async {
    List<Map<String, dynamic>> results = await _database.query(
      'ChatMessage',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
    return results.isNotEmpty
        ? results.map((data) => ChatMessage.fromJson(data)).toList()
        : [];
  }
}