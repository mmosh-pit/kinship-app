import 'dart:convert';

import 'package:bigagent/models/agent.dart';
import 'package:bigagent/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AgentsService {
  static final _client = DioClient();

  static Future<List<Agent>> getAgents() async {
    try {
      final response = await _client.get("/agents");

      if (response.data["data"] == null) return [];

      final data = response.data["data"] as List<dynamic>;

      return data.map((e) => Agent.fromJson(e)).toList();
    } catch (err) {
      debugPrint("Got an error here: $err");

      return [];
    }
  }

  static Future<String> activateAgent(String agentId) async {
    try {
      await _client.post(
        "/agents/activate",
        data: jsonEncode({"agentId": agentId}),
      );

      return "";
    } catch (err) {
      debugPrint("Got error trying to activate agent: $err");
      if (err is DioException) {
        final error = err.response!.data["errors"][0];
        return error;
      }
      rethrow;
    }
  }

  static Future<Set<String>> getActiveAgents() async {
    final response = await _client.get("/agents/active");

    Set<String> result = {};

    if (response.data["data"] != null) {
      final listData = response.data["data"] as List<dynamic>;

      for (final value in listData) {
        result.add(value["agentId"]);
      }
    }

    return result;
  }
}
