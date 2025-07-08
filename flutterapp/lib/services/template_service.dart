import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TemplateService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  Map<String, dynamic> _template = {};

  Future<void> loadTemplate() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/ui-template'));
      if (response.statusCode == 200) {
        _template = jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      // ignore fetch errors
    }
  }

  Color? get primaryColor => _parseColor(_template['primaryColor']);
  String? get logoUrl => _template['logoUrl'] as String?;
  String get welcomeText => _template['welcomeText'] as String? ?? 'Welcome';

  Color? _parseColor(dynamic value) {
    if (value is String && value.startsWith('#')) {
      return Color(int.parse(value.substring(1), radix: 16) + 0xFF000000);
    }
    return null;
  }
}

final templateService = TemplateService();
