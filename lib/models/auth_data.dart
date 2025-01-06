import 'package:bigagent/models/user.dart';

class AuthData {
  final bool isAuth;
  final User? user;

  AuthData({
    required this.isAuth,
    required this.user,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        isAuth: json["is_auth"],
        user: json["user"] != null
            ? User.fromJson(
                json["user"],
              )
            : null,
      );
}
