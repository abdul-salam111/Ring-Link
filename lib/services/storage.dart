import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final storage = FlutterSecureStorage();
  Future<bool> setValues(String key, dynamic value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  Future<dynamic> readValues(
    String key,
  ) async {
    var response = await storage.read(key: key);
    return response;
  }

  Future<dynamic> clearValues(
    String key,
  ) async {
    await storage.delete(key: key);
    return true;
  }
}
