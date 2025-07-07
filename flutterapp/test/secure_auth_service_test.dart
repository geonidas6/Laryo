import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage_mocks/flutter_secure_storage_mocks.dart';
import 'package:flutterapp/services/secure_auth_service.dart';

void main() {
  test('save and retrieve token', () async {
    final storage = MockFlutterSecureStorage();
    final service = SecureAuthService(storage: storage);
    await service.saveToken('abc');
    final token = await service.getToken();
    expect(token, 'abc');
    await service.clearToken();
    final cleared = await service.getToken();
    expect(cleared, isNull);
  });
}
