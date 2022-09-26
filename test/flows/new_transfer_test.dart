import 'dart:math';

import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/main.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/contacts_list.dart';
import 'package:bytebank_app/screens/dashboard.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers.dart';
import 'save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('Should transfer to some contact', ((tester) async {
    final mockContactDao = MockContactDao();
    when(mockContactDao.findAll())
        .thenAnswer((_) async => <Contact>[Contact(0, 'abc', 2580)]);
    when(mockContactDao.save(any)).thenAnswer((_) async => 1);

    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));

    final dash = find.byType(Dashboard);
    expect(dash, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);

    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsListScreen = find.byType(ContactsList);
    expect(contactsListScreen, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'abc' &&
            widget.contact.accountNumber == 2580;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transferFormScreen = find.byType(TransactionForm);
    expect(transferFormScreen, findsOneWidget);
  }));
}
