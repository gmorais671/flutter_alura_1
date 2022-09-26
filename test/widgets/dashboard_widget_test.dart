import 'package:bytebank_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers.dart';
import '../flows/save_contact_flow_test.mocks.dart';

void main() {
  final mockContactDao = MockContactDao();
  testWidgets('Should show main image when dashboard in opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Dashboard(
      contactDao: mockContactDao,
    )));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  testWidgets('Should display transfer feature when dash is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Dashboard(
      contactDao: mockContactDao,
    )));
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });
  testWidgets('Should display transaction feed feature when dash in opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Dashboard(
      contactDao: mockContactDao,
    )));
    final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));
    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}
