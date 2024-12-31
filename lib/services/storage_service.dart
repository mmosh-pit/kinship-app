import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final _singleton = StorageService._internal();

  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  factory StorageService() => _singleton;

  StorageService._internal();

  Future<void> saveKey(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getKeyValue(String key) async {
    final res = await storage.read(key: key);

    return res;
  }

  Future<void> removeKey(String key) async {
    await storage.delete(key: key);
  }
}
