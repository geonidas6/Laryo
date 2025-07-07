import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutterapp/main.dart';
import 'test_asset_loader.dart';

void main() {
  testWidgets('Shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: '',
        assetLoader: const TestAssetLoader({'login': 'Login'}),
        child: const MyApp(),
      ),
    );
    await tester.pump();
    expect(find.text('Login'), findsOneWidget);
  });
}
