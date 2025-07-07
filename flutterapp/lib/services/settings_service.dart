import 'api_service.dart';
import 'secure_auth_service.dart';

class SettingsService {
  final ApiService _api = ApiService();
  final SecureAuthService _auth = SecureAuthService();

  Future<Map<String, dynamic>> loadSettings() async {
    final token = await _auth.getToken();
    if (token == null) return {};
    final data = await _api.getSettings(token);
    return data ?? {};
  }

  Future<void> updateSetting(String key, dynamic value) async {
    final token = await _auth.getToken();
    if (token == null) return;
    await _api.updateSetting(token, key, value);
  }
}
