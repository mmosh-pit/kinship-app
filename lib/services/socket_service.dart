import 'dart:async';
import 'dart:convert';

import 'package:ai_app/models/message.dart';
import 'package:ai_app/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  final String serverUrl = "${dotenv.env["WS_URL"]!}/chat";
  WebSocketChannel? socket;

  final StreamController<Message> _messagesController =
      StreamController<Message>();

  void initialize() async {
    final token = await StorageService().getKeyValue("user_token");
    socket = WebSocketChannel.connect(Uri.parse("$serverUrl?token=$token"));
    await socket!.ready;

    socket!.stream.listen(
      (data) {
        if (data == "connected" || data == "") return;

        final decodedData = jsonDecode(data);

        if (decodedData == "connected") return;

        if (decodedData["event"] == "aiMessage") {
          final message = Message(
            id: decodedData["data"]["id"],
            content: decodedData["data"]["content"],
            type: "bot",
            sender: "",
          );
          _messagesController.add(message);
        } else {
          final message = Message.fromJson(decodedData);

          _messagesController.add(message);
        }
      },
      onDone: () async {
        await Future.delayed(const Duration(seconds: 5));
        initialize();
      },
      onError: (err) async {
        print("Got error: $err");
        await Future.delayed(const Duration(seconds: 5));
        initialize();
      },
    );
  }

  Stream<Message> getMessagesData() {
    return _messagesController.stream;
  }

  void dispose() {
    _messagesController.close();
    socket?.sink.close();
  }

  sendMessage(message) {
    socket?.sink.add(jsonEncode(message));
  }
}
