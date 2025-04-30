import 'package:bigagent/models/chat.dart';
import 'package:bigagent/utils/dio_client.dart';

class ChatService {
  static final _client = DioClient();

  static Future<List<Chat>> getChats() async {
    try {
      final response = await _client.get("/chats/active");

      final data = response.data["data"] as List<dynamic>;

      return data.map((e) => Chat.fromJson(e)).toList();
    } catch (err) {
      print("Got error: $err");
      return [];
    }
  }
}
