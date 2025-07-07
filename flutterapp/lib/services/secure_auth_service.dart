import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthService {
  static const _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage;

  SecureAuthService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
