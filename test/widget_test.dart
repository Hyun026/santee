// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sante_en_poche/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
   testWidgets('MyApp shows MainScreen when connected', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(isConnected: true));

    expect(find.byType(MainScreen), findsOneWidget);
    expect(find.byType(NoConnectionScreen), findsNothing);
  });

  testWidgets('MyApp shows NoConnectionScreen when not connected', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(isConnected: false));

    expect(find.byType(MainScreen), findsNothing);
    expect(find.byType(NoConnectionScreen), findsOneWidget);
  });

   
  });
}
