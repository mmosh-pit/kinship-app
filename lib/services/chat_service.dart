import 'package:bigagent/models/chat.dart';
import 'package:bigagent/utils/dio_client.dart';

class ChatService {
  static final _client = DioClient();

  static Future<Chat> getChat() async {
    final response = await _client.get("/get-or-create-chat");

    final data = response.data["data"];

    final result = Chat.fromJson(data);

    return result;
  }
}
