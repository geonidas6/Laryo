import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CMSBlockService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<String?> get(String key) async {
    final response = await http.get(Uri.parse('$baseUrl/api/blocks/$key'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['value'] as String?;
    }
    return null;
  }
}
