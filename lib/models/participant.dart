class Participant {
  final String id;
  final String name;
  final String type;
  final String picture;

  Participant({
    required this.id,
    required this.name,
    required this.type,
    required this.picture,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        picture: json["picture"],
      );

  static Participant empty() =>
      Participant(id: "", name: "", type: "", picture: "");
}
