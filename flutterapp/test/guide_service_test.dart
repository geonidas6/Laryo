import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterapp/services/guide_service.dart';

void main() {
  test('Guide service loads base url', () {
    dotenv.testLoad(fileInput: 'API_BASE_URL=http://test');
    final service = GuideService();
    expect(service.baseUrl, 'http://test');
  });
}
