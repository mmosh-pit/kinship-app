class Message {
  final String id;
  final String content;
  final String type;
  final String sender;
  final bool isLoading;

  Message({
    required this.id,
    required this.content,
    required this.type,
    required this.sender,
    this.isLoading = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        content: json["content"],
        type: json["type"],
        sender: json["sender"],
      );

  Message copyWith({
    String? content,
    bool? isLoading,
  }) =>
      Message(
        id: id,
        content: content ?? this.content,
        type: type,
        sender: sender,
        isLoading: isLoading ?? this.isLoading,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "type": type,
        "sender": sender,
      };
}
