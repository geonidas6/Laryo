import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterapp/services/cms_block_service.dart';

void main() {
  test('Base URL loaded from env', () {
    dotenv.testLoad(fileInput: 'API_BASE_URL=http://test');
    final service = CMSBlockService();
    expect(service.baseUrl, 'http://test');
  });
}
