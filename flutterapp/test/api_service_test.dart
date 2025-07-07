import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterapp/services/api_service.dart';

void main() {
  test('Base URL loaded from env', () {
    dotenv.testLoad(fileInput: 'API_BASE_URL=http://test');
    final service = ApiService();
    expect(service.baseUrl, 'http://test');
  });
}
