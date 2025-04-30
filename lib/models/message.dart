class Message {
  final String id;
  final String content;
  final String type;
  final String createdAt;
  final String sender;
  final String agentId;
  final String chatId;
  final bool isLoading;

  Message({
    required this.id,
    required this.content,
    required this.type,
    required this.sender,
    required this.createdAt,
    required this.chatId,
    required this.agentId,
    this.isLoading = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    content: json["content"],
    type: json["type"],
    sender: json["sender"],
    createdAt: json["created_at"],
    isLoading: json["is_loading"] ?? false,
    chatId: json["chat_id"],
    agentId: json["agent_id"],
  );

  Message copyWith({String? content, bool? isLoading}) => Message(
    id: id,
    content: content ?? this.content,
    type: type,
    sender: sender,
    createdAt: createdAt,
    isLoading: isLoading ?? this.isLoading,
    chatId: chatId,
    agentId: agentId,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "type": type,
    "sender": sender,
  };
}
