import 'package:bigagent/models/message.dart';
import 'package:bigagent/models/participant.dart';

class Chat {
  final String id;
  final List<Participant> participants;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["id"],
      participants: json["participants"] != null
          ? json["participants"]
              .map<Participant>(
                (e) => Participant.fromJson(e),
              )
              .toList()
          : [],
      messages: json["messages"] != null
          ? json["messages"].map<Message>((e) => Message.fromJson(e)).toList()
          : [],
    );
  }

  static empty() {
    return Chat(id: "", participants: [], messages: []);
  }

  Chat addMessage(Message message) => Chat(
        id: id,
        participants: participants,
        messages: [...messages, message],
      );

  Chat modifyLastMessage(Message message) {
    final newMessages = [...messages];

    newMessages[newMessages.length - 1] = message;

    return Chat(
      id: id,
      participants: participants,
      messages: [...newMessages],
    );
  }
}
