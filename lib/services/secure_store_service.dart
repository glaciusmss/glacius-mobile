import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class SecureStoreService {
  FlutterSecureStorage _flutterSecureStorage;

  SecureStoreService({FlutterSecureStorage flutterSecureStorage}) {
    flutterSecureStorage ??= FlutterSecureStorage();
    this._flutterSecureStorage = flutterSecureStorage;
  }

  Future<String> getToken() async {
    return await this._flutterSecureStorage.read(key: 'token');
  }

  Future<bool> hasToken() async {
    String token = await this.getToken();
    return token != null;
  }

  Future<void> persistToken({@required String token}) async {
    await this._flutterSecureStorage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await this._flutterSecureStorage.delete(key: 'token');
  }
}
