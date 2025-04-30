class Agent {
  final String id;
  final String name;
  final String desc;
  final String image;
  final String key;
  final String symbol;
  final String systemPrompt;
  final String creatorUsername;
  final String type;

  Agent({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.symbol,
    required this.key,
    required this.systemPrompt,
    required this.creatorUsername,
    required this.type,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    image: json["image"],
    key: json["key"],
    symbol: json["symbol"],
    systemPrompt: json["system_prompt"],
    creatorUsername: json["creatorUsername"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "desc": desc,
    "image": image,
    "key": key,
    "symbol": symbol,
    "system_prompt": systemPrompt,
    "creatorUsername": creatorUsername,
    "type": type,
  };
}
