import 'dart:convert';

import 'package:kinship_bots/models/auth_data.dart';
import 'package:kinship_bots/utils/dio_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  static final _client = DioClient();

  static Future<Map<String, dynamic>> login({
    required String handle,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        "/login",
        data: jsonEncode(
          {
            "handle": handle,
            "password": password,
          },
        ),
      );

      return response.data["data"];
    } catch (err) {
      if (err is DioException) {
        throw Error.safeToString(err.response!.data["errors"][0]);
      }

      rethrow;
    }
  }

  static Future<AuthData> checkAuthenticated() async {
    final response = await _client.get("/is-auth");

    final data = response.data["data"];

    return AuthData.fromJson(data);
  }

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String emailAddress,
    required String password,
    required int code,
  }) async {
    final response = await _client.post(
      "/signup",
      data: jsonEncode(
        {
          "email": emailAddress,
          "password": password,
          "name": name,
          "code": code,
        },
      ),
    );

    return response.data["data"];
  }

  static Future<void> requestCode(String email) async {
    await _client.post(
      "/request-code",
      data: jsonEncode(
        {"email": email},
      ),
    );
  }

  static Future<void> logout() async {
    await _client.delete("/logout");
  }
}
