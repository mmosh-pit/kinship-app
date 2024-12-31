class User {
  String id;
  String name;
  String email;
  String address;
  String referredBy;
  int telegramId;
  String privateKey;
  BlueskyData? bsky;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.referredBy,
    required this.telegramId,
    required this.privateKey,
    this.bsky,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? "",
      name: json['name'],
      email: json['email'],
      address: json['address'],
      referredBy: json['referredBy'],
      telegramId: json['telegramId'],
      privateKey: json['privateKey'],
      bsky: json['bsky'] != null ? BlueskyData.fromJson(json['bsky']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['referredBy'] = referredBy;
    data['telegramId'] = telegramId;
    data['privateKey'] = privateKey;
    if (bsky != null) {
      data['bsky'] = bsky!.toJson();
    }
    data["_id"] = id;
    return data;
  }
}

class BlueskyData {
  String id;
  String handle;
  String token;
  String refreshToken;

  BlueskyData({
    required this.id,
    required this.handle,
    required this.token,
    required this.refreshToken,
  });

  factory BlueskyData.fromJson(Map<String, dynamic> json) {
    return BlueskyData(
      id: json['id'],
      handle: json['handle'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handle'] = handle;
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
