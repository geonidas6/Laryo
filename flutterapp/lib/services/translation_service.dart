import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiAssetLoader extends AssetLoader {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/translations/${locale.languageCode}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return {};
  }
}
