import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GuideStepModel {
  final String title;
  final String content;
  GuideStepModel({required this.title, required this.content});

  factory GuideStepModel.fromJson(Map<String, dynamic> json) =>
      GuideStepModel(
        title: json['title'] as String,
        content: json['content'] as String? ?? '',
      );
}

class GuideService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<GuideStepModel>> fetchSteps() async {
    final response = await http.get(Uri.parse('$baseUrl/api/guides'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final steps = data.first['steps'] as List<dynamic>? ?? [];
        return steps.map((e) => GuideStepModel.fromJson(e)).toList();
      }
    }
    return [];
  }
}
