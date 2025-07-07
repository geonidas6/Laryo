import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';

class AnalyticsService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final AuthService _auth = AuthService();

  Future<void> trackPage(String page) async {
    final token = await _auth.getToken();
    await http.post(
      Uri.parse('$baseUrl/api/analytics'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'page': page}),
    );
  }
}
