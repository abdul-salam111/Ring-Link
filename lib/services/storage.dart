import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  // Make the class a singleton
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;

  LocalStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> setValues(String key, String value) async {
    await _storage.write(key: key, value: value);
    return true;
  }

  readValues(String key) {
    return _storage.read(key: key);
  }

  Future<bool> clearValues(String key) async {
    await _storage.delete(key: key);
    return true;
  }
}

// Global getter
final LocalStorage storage = LocalStorage();

class StorageKeys {
  static const String artistDetails = 'artistDetails';
  static const String trainerDetails = 'trainerDetails';
  static const String loggedIn = 'loggedIn';
  static const String token = "token";
  static const String userId = 'userId';
  static const String userType = 'userType';
  static const String chooseRoleDone = 'chooseRoleDone';
  static const String onboardingCompleted = 'onboardingCompleted';
  static const String deviceToken = 'deviceToken';
}

enum UserType {
  artist,
  trainer,
}

extension LocalStorageGetters on LocalStorage {
  Future<String?> get userId async {
    return await readValues(StorageKeys.userId);
  }
}

extension UserTypeExtension on BuildContext {

}
