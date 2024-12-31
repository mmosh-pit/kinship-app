import 'dart:convert';

import 'package:ai_app/utils/dio_client.dart';
import 'package:ai_app/utils/helius_client.dart';

class HeliusService {
  static final _client = HeliusClient();
  static final _dioClient = DioClient();

  static Future<dynamic> fetchWalletData(String wallet) async {
    final data = {
      "jsonrpc": "2.0",
      "id": "1",
      "method": "getAssetsByOwner",
      "params": {
        "ownerAddress": wallet,
        "displayOptions": {
          "showFungible": true,
          "showCollectionMetadata": true,
          "showUnverifiedCollections": true,
        },
        "page": 1,
        "limit": 1000,
      }
    };

    final result = await _client.post("", data: jsonEncode(data));

    return result.data;
  }

  static Future<List<String>> getAllTokenAddreses() async {
    final response = await _dioClient.get("/all-tokens");

    return List<String>.from(response.data["data"] as List<dynamic>);
  }
}
