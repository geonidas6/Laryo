import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeatureManagerService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  static const _cacheKey = 'feature_flags';
  Map<String, bool> _flags = {};

  Future<void> loadFeatures() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/features'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _flags = data.map((k, v) => MapEntry(k, v as bool));
        await prefs.setString(_cacheKey, jsonEncode(_flags));
        return;
      }
    } catch (_) {
      // ignore errors and fall back to cache
    }
    final cached = prefs.getString(_cacheKey);
    if (cached != null) {
      final Map<String, dynamic> data = jsonDecode(cached);
      _flags = data.map((k, v) => MapEntry(k, v as bool));
    }
  }

  bool isEnabled(String name) => _flags[name] ?? false;
}

final featureManager = FeatureManagerService();
