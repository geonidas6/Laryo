import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutterapp/screens/login_screen.dart';
import 'test_asset_loader.dart';

void main() {
  testWidgets('Login button disabled when fields empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: '',
        assetLoader: const TestAssetLoader({
          'login': 'Login',
          'email': 'Email',
          'password': 'Password',
          'required': 'Required',
          'register': 'Register'
        }),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.pump();
    final ElevatedButton button = tester.widget(find.widgetWithText(ElevatedButton, 'Login'));
    expect(button.onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).first, 'email');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.pump();

    final ElevatedButton enabledButton = tester.widget(find.widgetWithText(ElevatedButton, 'Login'));
    expect(enabledButton.onPressed, isNotNull);
  });
}
