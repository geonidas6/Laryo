import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/widgets/badge_wall.dart';

void main() {
  testWidgets('BadgeWall shows badges', (WidgetTester tester) async {
    final badges = [
      {'name': 'A'},
      {'name': 'B'},
    ];
    await tester.pumpWidget(MaterialApp(home: BadgeWall(badges: badges)));
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}
