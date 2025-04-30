import 'package:bigagent/models/agent.dart';
import 'package:bigagent/models/message.dart';
import 'package:bigagent/models/participant.dart';

class Chat {
  final String id;
  final List<Participant> participants;
  final List<Message> messages;
  final bool deactivated;
  final Agent? agent;
  final Message? lastMessage;

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
    required this.deactivated,
    this.agent,
    this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["id"],
      participants:
          json["participants"] != null
              ? json["participants"]
                  .map<Participant>((e) => Participant.fromJson(e))
                  .toList()
              : [],
      messages:
          json["messages"] != null
              ? json["messages"]
                  .map<Message>((e) => Message.fromJson(e))
                  .toList()
              : [],
      deactivated: json["deactivated"] ?? false,
      agent:
          json["chatAgent"] != null ? Agent.fromJson(json["chatAgent"]) : null,
      lastMessage: json["lastMessage"],
    );
  }

  static empty() {
    return Chat(id: "", participants: [], messages: [], deactivated: false);
  }

  Chat addMessage(Message message) => Chat(
    id: id,
    participants: participants,
    messages: [...messages, message],
    deactivated: deactivated,
    agent: agent,
    lastMessage: lastMessage,
  );

  Chat modifyLastMessage(Message message) {
    final newMessages = [...messages];

    newMessages[newMessages.length - 1] = message;

    return Chat(
      id: id,
      participants: participants,
      messages: [...newMessages],
      deactivated: deactivated,
      agent: agent,
      lastMessage: lastMessage,
    );
  }
}
